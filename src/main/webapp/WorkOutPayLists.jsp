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
		com.bionic.edu.PayListService payListService = (com.bionic.edu.PayListService) context
				.getBean("payListServiceImpls");
		com.bionic.edu.MerchantService merchantService = (com.bionic.edu.MerchantService) context
				.getBean("merchantServiceImpl");

		java.util.List<com.bionic.edu.PayList> notPaidPaymentLists = payListService.findNotPaid();

		java.util.Map<Integer, com.bionic.edu.PayList> notPaidPLMap = new java.util.HashMap();
		for (com.bionic.edu.PayList pl : notPaidPaymentLists) {
			notPaidPLMap.put(pl.getMerchantId(), pl);
		}

		java.util.List<com.bionic.edu.Merchant> merchants = merchantService.findReadyToBePayed();
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		java.sql.Timestamp timestamp = new java.sql.Timestamp(sqlDate.getTime());

		for (com.bionic.edu.Merchant merch : merchants) {
			com.bionic.edu.PayList pl = new com.bionic.edu.PayList();
			Integer merchantId = merch.getId();
			pl.setMerchantId(merchantId);
			pl.setSentDate(timestamp);
			pl.setStatus("NotPaid");
			pl.setSumSent(merch.getNeedToSend());
			pl.setPriority(1);

			com.bionic.edu.PayList notPaidPL = notPaidPLMap.get(merchantId);
			if (notPaidPL != null) {
				notPaidPL.setStatus("Modified");
				payListService.save(notPaidPL);
				pl.setPriority(notPaidPL.getPriority() + 1);
			}

			payListService.save(pl);
		}
	%>
	<form action="workOutPayLists.jsp" method="POST">
		<input type="submit" value="Submit" class="button" />
	</form>
</body>
</html>