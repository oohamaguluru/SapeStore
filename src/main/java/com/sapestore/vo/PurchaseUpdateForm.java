package com.sapestore.vo;

import java.util.List;

public class PurchaseUpdateForm {

	List<PurchaseUpdate> paymentUpdateList;

	public List<PurchaseUpdate> getPaymentUpdateList() {
		return paymentUpdateList;
	}

	public void setPaymentUpdateList(List<PurchaseUpdate> paymentUpdateList) {
		this.paymentUpdateList = paymentUpdateList;
	}

	@Override
	public String toString() {
		return "PurchaseUpdateForm [paymentUpdateList=" + paymentUpdateList + "]";
	}
	
	
}
