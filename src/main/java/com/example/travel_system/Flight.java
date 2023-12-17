package com.example.travel_system;
import java.sql.*;

public class Flight {
    private int flightID;
    private String airlineID;
    private int aircraftID;
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private String departureAirport;
    private String arrivalAirport;
    private String dayOfWeek;
    private boolean isInternational;
    private double fare;
    private double bookingFee;
    private int duration;

    public Flight() {
    }

    public Flight(int flightID, String airlineID, int aircraftID, Timestamp departureTime, Timestamp arrivalTime, String departureAirport, String arrivalAirport, String dayOfWeek, int isInternational, double fare, double bookingFee, int duration) {
        this.flightID = flightID;
        this.airlineID = airlineID;
        this.aircraftID = aircraftID;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.departureAirport = departureAirport;
        this.arrivalAirport = arrivalAirport;
        this.dayOfWeek = dayOfWeek;
        this.isInternational = isInternational == 1;
        this.fare = fare;
        this.bookingFee = bookingFee;
        this.duration = duration;
    }

    public String getAirlineID() {
        return airlineID;
    }

    public void setAirlineID(String airlineID) {
        this.airlineID = airlineID;
    }

    public int getAircraftID() {
        return aircraftID;
    }

    public void setAircraftID(int aircraftID) {
        this.aircraftID = aircraftID;
    }

    public int getFlightID() {
        return flightID;
    }

    public void setFlightID(int flightID) {
        this.flightID = flightID;
    }

    public Timestamp getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Timestamp departureTime) {
        this.departureTime = departureTime;
    }

    public Timestamp getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Timestamp arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getDepartureAirport() {
        return departureAirport;
    }

    public void setDepartureAirport(String departureAirport) {
        this.departureAirport = departureAirport;
    }

    public String getArrivalAirport() {
        return arrivalAirport;
    }

    public void setArrivalAirport(String arrivalAirport) {
        this.arrivalAirport = arrivalAirport;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public boolean isInternational() {
        return isInternational;
    }

    public void setInternational(int international) {
        isInternational = international == 1;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }

    public double getBookingFee() {
        return bookingFee;
    }

    public void setBookingFee(double bookingFee) {
        this.bookingFee = bookingFee;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    @Override
    public String toString() {
        return "Flight{" +
                "flightID=" + flightID +
                ", airlineID='" + airlineID + '\'' +
                ", aircraftID=" + aircraftID +
                ", departureTime='" + departureTime + '\'' +
                ", arrivalTime='" + arrivalTime + '\'' +
                ", departureAirport='" + departureAirport + '\'' +
                ", arrivalAirport='" + arrivalAirport + '\'' +
                ", dayOfWeek='" + dayOfWeek + '\'' +
                ", isInternational=" + isInternational +
                ", fare=" + fare +
                ", bookingFee=" + bookingFee +
                ", duration=" + duration +
                '}';
    }
}
