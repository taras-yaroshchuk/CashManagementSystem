<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Get PaymentLists</title>
<link rel="stylesheet" type="text/css" href="web.css" />
</head>

<body>
	<h1>Work Out Pay Lists:</h1>

	<%
		org.springframework.context.ApplicationContext context = new org.springframework.context.support.ClassPathXmlApplicationContext(
				"spring/application-config.xml");
		com.bionic.edu.PaymentListService paymentListService = (com.bionic.edu.PaymentListService) context
				.getBean("paymentListServiceImpls");
		com.bionic.edu.MerchantService merchantService = (com.bionic.edu.MerchantService) context
				.getBean("merchantServiceImpl");

		java.util.List<com.bionic.edu.PaymentList> notPaidPaymentLists = paymentListService.findNotPaid();

		java.util.Map<Integer, com.bionic.edu.PaymentList> notPaidPLMap = new java.util.HashMap();
		for (com.bionic.edu.PaymentList pl : notPaidPaymentLists) {
			notPaidPLMap.put(pl.getMerchantId(), pl);
		}

		java.util.List<com.bionic.edu.Merchant> merchants = merchantService.findReadyToBePayed();
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		java.sql.Timestamp timestamp = new java.sql.Timestamp(sqlDate.getTime());

		for (com.bionic.edu.Merchant merch : merchants) {
			com.bionic.edu.PaymentList pl = new com.bionic.edu.PaymentList();
			Integer merchantId = merch.getId();
			pl.setMerchantId(merchantId);
			pl.setSentDate(timestamp);
			pl.setStatus("NotPaid");
			pl.setSumSent(merch.getNeedToSend());
			pl.setPriority(1);

			com.bionic.edu.PaymentList notPaidPL = notPaidPLMap.get(merchantId);
			if (notPaidPL != null) {
				notPaidPL.setStatus("Modified");
				paymentListService.save(notPaidPL);
				pl.setPriority(notPaidPL.getPriority() + 1);
			}

			paymentListService.save(pl);
		}
	%>
	<form action="WorkOutPayLists.jsp" method="POST">
		<input type="submit" value="Submit" class="button" />
	</form>
</body>
</html>