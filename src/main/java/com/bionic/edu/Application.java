package com.bionic.edu;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Random;

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
	
	@Inject
	PaymentListService paymentListService;
	

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

		//application.test();
		
		application.getReadyToBePayed();
	}

	


	private void test() {
		Random rand = new Random();
		for(Merchant m: merchantService.findAll()) {
			m.setSent(1000 + rand.nextInt(5000));
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		    m.setLastSent(sqlDate);
			merchantService.save(m);
		}
		
	}
	
	private void getReadyToBePayed() {
		List<Merchant> list = merchantService.findReadyToBePayed();
		for (Merchant m : list) {
			System.out.format("%1$27s     %2$4.2f  %n", m.getName(), m.getCharge());
		}
	}




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
//		 customer.setMaturity(new Date());
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
