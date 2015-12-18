package com.bionic.edu;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

@Named
public class Application {
	@Inject
	MerchantService merchantService;

	@Inject
	CustomerService customerService;

	@Inject
	PaymentService paymentService;

	@SuppressWarnings("resource")
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("spring/application-config.xml");
		Application application = (Application) context.getBean("application");

		// application.printMerchantName(1);

		// int id = application.addMerchant();
		// System.out.println("New merchant id = " + id);

		// int id = application.addCustomer();
		// System.out.println("New customer id = " + id);

		// Merchant m = application.getByIdSetName(1, "Jim Smith Ltd.NEW");

		// application.findAll();

		// application.getPaymentsForMerchant(3);

		// application.getCustomersWithLargePays(500.0);

		// application.getSumToPay();

		// application.getTotalReport();

		// application.findPayment(2);

		// application.printPayments();

		// application.printMerchantsOfCustomer(3);

	}

	private void printMerchantsOfCustomer(int id) {
		Customer customer = customerService.findById(id);
		if (customer != null) {
			Collection<Merchant> merchants = customer.getMerchants();
			System.out.println("Customer " + customer.getName() + ":");
			for (Merchant m : merchants) {
				System.out.println(m.getName());
			}
		}
	}

	private void printPayments() {

		List<Merchant> list = merchantService.getSortedByNeedToPay();
		for (Merchant m : list) {
			System.out.println("=======================");
			System.out.println(m.getName());
			Collection<Payment> payments = m.getPayments();
			for (Payment p : payments) {
				System.out.println(p.toString());
			}
		}
	}

	public void findPayment(int id) {
		Payment p = paymentService.findById(id);
		SimpleDateFormat fmt = new SimpleDateFormat("dd.MM.yyyy HH:mm");
		System.out.println("Date = " + fmt.format(p.getDt()) + "   	merchant = " + p.getMerchant().getName()
				+ "   sum 	= " + p.getSumPayed());
	}



	public void getSumToPay() {
		List<Merchant> list = merchantService.getSortedByNeedToPay();
		System.out.println("        Merchant           Sum to Pay");
		for (Merchant m : list) {
			System.out.format("%1$-25s  %2$8.2f  %n", m.getName(), m.getNeedToSend());
		}
	}

	public void getCustomersWithLargePays(double limit) {
		List<String> list = customerService.getNames(limit);
		for (String s : list)
			System.out.println(s);
	}

	// public void getPaymentsForMerchant(int id) {
	// List<Payment> list = paymentService.findByMerchantId(id);
	// System.out.println(" date merchant sum ");
	// for(Payment p: list){
	// SimpleDateFormat dtFrm = new
	// SimpleDateFormat("dd.MM.yyyy HH:mm");
	// String txDate = dtFrm.format(p.getDt());
	// System.out.format(" %1s %2$3d %3$6.2f %n",
	// txDate, p.getMerchantId(), p.getSumPayed());
	// }
	// }

	public void findAll() {
		List<Merchant> list = merchantService.findAll();
		System.out.println("           name              charge");
		for (Merchant m : list) {
			System.out.format("%1$27s     %2$4.2f  %n", m.getName(), m.getCharge());
		}
	}

	private Merchant getByIdSetName(int id, String newName) {
		Merchant temp = merchantService.findById(id);
		temp.setName(newName);
		merchantService.save(temp);
		return temp;
	}

	private int addCustomer() {
		Customer customer = new Customer();
		customer.setName("Taras");
		customer.setAddress("Vushnyakivska 7-B");
		customer.setCcNo("454465242");
		customer.setCcType("Visa");
		customer.setEmail("taras.yaroshchuk@gmail.com");
		// customer.setMaturity(new Date());
		customerService.save(customer);
		return customer.getId();
	}

	public void printMerchantName(int id) {
		Merchant m1 = merchantService.findById(id);
		System.out.println("name = " + m1.getName());
	}

	public int addMerchant() {
		Merchant merchant = new Merchant();
		merchant.setAccount("555555555");
		merchant.setBankName("Erste Bank");
		merchant.setCharge(1.2);
		merchant.setMinSum(145.0);
		merchant.setName("N&M");
		merchant.setPeriod((short) 1);
		merchant.setSwift("X85T44wwq");
		merchantService.save(merchant);
		return merchant.getId();
	}

}
