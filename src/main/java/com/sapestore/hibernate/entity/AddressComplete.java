package com.sapestore.hibernate.entity;

public class AddressComplete {
	
	Address address;
	City city;
	State state;
	Country country;
	
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
	}
	public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "AddressComplete [address=" + address + ", city=" + city + ", state=" + state + "]";
	}
	

}
