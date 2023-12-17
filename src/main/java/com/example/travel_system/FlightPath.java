package com.example.travel_system;

import java.sql.*;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.time.*;

public class FlightPath {
    private List<Flight> flightList;
    private List<String> airlineIds;
    private List<Integer> aircraftIds;
    private List<Integer> flightIds;
    private List<Timestamp> departureTimes;
    private List<Timestamp> arrivalTimes;
    private List<String> departureAirports;
    private List<String> arrivalAirports;
    private List<String> daysOfWeek;
    private List<Boolean> areInternational;
    private double fare;
    private double bookingFee;
    private int duration;

    public FlightPath() {
        this.flightList = new ArrayList<>();
        this.airlineIds = new ArrayList<>();
        this.aircraftIds = new ArrayList<>();
        this.flightIds = new ArrayList<>();
        this.departureTimes = new ArrayList<>();
        this.arrivalTimes = new ArrayList<>();
        this.departureAirports = new ArrayList<>();
        this.arrivalAirports = new ArrayList<>();
        this.daysOfWeek = new ArrayList<>();
        this.areInternational = new ArrayList<>();
        this.fare = 0;
        this.bookingFee = 0;
        this.duration = 0;
    }


    public FlightPath(List<Flight> flightList, List<String> airlineIds, List<Integer> aircraftIds, List<Integer> flightIds, List<Timestamp> departureTimes, List<Timestamp> arrivalTimes, List<String> departureAirports, List<String> arrivalAirports, List<String> daysOfWeek, List<Boolean> areInternational, double fare, double bookingFee, int duration) {
        this.flightList = flightList;
        this.airlineIds = airlineIds;
        this.aircraftIds = aircraftIds;
        this.flightIds = flightIds;
        this.departureTimes = departureTimes;
        this.arrivalTimes = arrivalTimes;
        this.departureAirports = departureAirports;
        this.arrivalAirports = arrivalAirports;
        this.daysOfWeek = daysOfWeek;
        this.areInternational = areInternational;
        this.fare = fare;
        this.bookingFee = bookingFee;
        this.duration = duration;
    }

    public void addFlight(Flight flight) {
        if (flightList.isEmpty() || (flightList.get(flightList.size() - 1).getArrivalTime().compareTo(flight.getDepartureTime()) < 0)) {
            flightList.add(flight);
        }
    }

    public List<Flight> getFlightList() {
        return flightList;
    }

    public List<FlightPath> findFlightPaths(String departure, String destination, int maxStops, boolean flex, LocalDate desiredDate, Connection con) throws SQLException {
        List<FlightPath> validPaths = new ArrayList<>();
        findFlightPathsRecursive(departure, destination, maxStops, new FlightPath(), validPaths, flex, desiredDate,  con);

        for (FlightPath paths : validPaths) {
            for (Flight flight : paths.getFlightList()) {
                paths.getAirlineIds().add(flight.getAirlineID());
                paths.getAircraftIds().add(flight.getAircraftID());
                paths.getFlightIds().add(flight.getFlightID());
                paths.getDepartureTimes().add(flight.getDepartureTime());
                paths.getArrivalTimes().add(flight.getArrivalTime());
                paths.getDepartureAirports().add(flight.getDepartureAirport());
                paths.getArrivalAirports().add(flight.getArrivalAirport());
                paths.getDaysOfWeek().add(flight.getDayOfWeek());
                paths.getAreInternational().add(flight.isInternational());
                paths.setFare(paths.getFare() + flight.getFare());
                paths.setBookingFee(paths.getBookingFee() + flight.getBookingFee());
                paths.setDuration(paths.getDuration() + flight.getDuration());
            }
        }
        return validPaths;
    }

    private void findFlightPathsRecursive(String currentAirport, String destination, int stopsLeft, FlightPath currentPath, List<FlightPath> validPaths, boolean flex, LocalDate desiredDate, Connection con) throws SQLException {
        if (stopsLeft < 0) {
            return;
        }

        String query = "SELECT * FROM flight WHERE departure_apt = '" + currentAirport + "' ORDER BY departure_time";
        try (Statement st = con.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Flight flight = new Flight(rs.getInt("f_id"), rs.getString("airline_id"), rs.getInt("aircraft_id"),
                        rs.getTimestamp("departure_time"), rs.getTimestamp("arrival_time"), rs.getString("departure_apt"),
                        rs.getString("arrival_apt"), rs.getString("day_of_week"), rs.getInt("is_international"),
                        rs.getDouble("fare"), rs.getDouble("booking_fee"), rs.getInt("duration_minutes"));

                if (currentPath.getFlightList().isEmpty() && flex) {
                    LocalDate flightDepartureDate = flight.getDepartureTime().toLocalDateTime().toLocalDate();
                    long daysBetween = ChronoUnit.DAYS.between(desiredDate, flightDepartureDate);
                    if (Math.abs(daysBetween) > 3) {
                        continue;
                    }
                }

                if (!currentPath.getFlightList().isEmpty()) {
                    Duration duration = Duration.between(currentPath.getFlightList().get(currentPath.getFlightList().size() - 1).getArrivalTime().toLocalDateTime(), flight.getDepartureTime().toLocalDateTime());
                    long hours = duration.toHours();
                    if (hours > 12 ) continue;
                }
                if (!currentPath.getFlightList().isEmpty() &&
                        (currentPath.getFlightList().get(currentPath.getFlightList().size() - 1).getArrivalTime().compareTo(flight.getDepartureTime()) > 0)) {
                    continue;
                }

                FlightPath newPath = new FlightPath();
                newPath.getFlightList().addAll(currentPath.getFlightList());
                newPath.addFlight(flight);
                if (flight.getArrivalAirport().equalsIgnoreCase(destination)) {
                    validPaths.add(newPath);
                } else if (stopsLeft > 0) {
                    findFlightPathsRecursive(flight.getArrivalAirport(), destination, stopsLeft - 1, newPath, validPaths, flex, desiredDate, con);
                }
            }
        }
    }

    public void setFlightList(List<Flight> flightList) {
        this.flightList = flightList;
    }

    public List<String> getAirlineIds() {
        return airlineIds;
    }

    public void setAirlineIds(List<String> airlineIds) {
        this.airlineIds = airlineIds;
    }

    public List<Integer> getAircraftIds() {
        return aircraftIds;
    }

    public void setAircraftIds(List<Integer> aircraftIds) {
        this.aircraftIds = aircraftIds;
    }

    public List<Integer> getFlightIds() {
        return flightIds;
    }

    public void setFlightIds(List<Integer> flightIds) {
        this.flightIds = flightIds;
    }

    public List<Timestamp> getDepartureTimes() {
        return departureTimes;
    }

    public void setDepartureTimes(List<Timestamp> departureTimes) {
        this.departureTimes = departureTimes;
    }

    public List<Timestamp> getArrivalTimes() {
        return arrivalTimes;
    }

    public void setArrivalTimes(List<Timestamp> arrivalTimes) {
        this.arrivalTimes = arrivalTimes;
    }

    public List<String> getDepartureAirports() {
        return departureAirports;
    }

    public void setDepartureAirports(List<String> departureAirports) {
        this.departureAirports = departureAirports;
    }

    public List<String> getArrivalAirports() {
        return arrivalAirports;
    }

    public void setArrivalAirports(List<String> arrivalAirports) {
        this.arrivalAirports = arrivalAirports;
    }

    public List<String> getDaysOfWeek() {
        return daysOfWeek;
    }

    public void setDaysOfWeek(List<String> daysOfWeek) {
        this.daysOfWeek = daysOfWeek;
    }

    public List<Boolean> getAreInternational() {
        return areInternational;
    }

    public void setAreInternational(List<Boolean> areInternational) {
        this.areInternational = areInternational;
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

    private static void printFlightPaths(List<FlightPath> flightPaths) {
        if (flightPaths.isEmpty()) {
            System.out.println("No flight paths found.");
            return;
        }

        for (FlightPath path : flightPaths) {
            System.out.println("Flight Path:");
            for (Flight flight : path.getFlightList()) {
                System.out.println(flight);
            }
            System.out.println("---------");
        }
    }


    @Override
    public String toString() {
        return "FlightPath{" +
                "flightList=" + flightList +
                '}';
    }
}
