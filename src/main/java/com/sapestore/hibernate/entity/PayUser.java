package com.sapestore.hibernate.entity;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Component
@Entity
@Table(name = "SAPESTORE_PAY_USER")
public class PayUser {
	
	
	@Id
	long phone;
	@Column(name = "amount", nullable = false, columnDefinition = "double default 0")
	double amount;
	String name;
    String password;

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getPhone() {
		return phone;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "User [name=" + name + ", phone=" + phone + ", amount=" + amount + ", password=" + password + "]";
	}

	
	
	
	
	
	

}
