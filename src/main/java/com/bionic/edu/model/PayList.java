package com.bionic.edu.model;

import java.util.Collection;

import javax.persistence.*;

@Entity
public class PayList {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private java.sql.Timestamp sentDate;
	private java.sql.Timestamp formedDate;
	private int merchantId;
	private String status;
	private Double sumSent;
	private int priority;

	public PayList() {
	}

	public java.sql.Timestamp getSentDate() {
		return sentDate;
	}

	public void setSentDate(java.sql.Timestamp sentDate) {
		this.sentDate = sentDate;
	}

	public java.sql.Timestamp getFormedDate() {
		return formedDate;
	}

	public void setFormedDate(java.sql.Timestamp formedDate) {
		this.formedDate = formedDate;
	}

	public int getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(int merchantId) {
		this.merchantId = merchantId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Double getSumSent() {
		return sumSent;
	}

	public void setSumSent(Double sumSent) {
		this.sumSent = sumSent;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public int getId() {
		return id;
	}
}
