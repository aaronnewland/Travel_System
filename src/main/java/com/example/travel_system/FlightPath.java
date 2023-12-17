package com.example.travel_system;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.*;

public class FlightPath {
    private List<Flight> flightList;

    public FlightPath() {
        this.flightList = new ArrayList<>();
    }

    public void addFlight(Flight flight) {
        if (flightList.isEmpty() || (flightList.get(flightList.size() - 1).getArrivalTime().compareTo(flight.getDepartureTime()) < 0)) {
            flightList.add(flight);
        }
    }

    public List<Flight> getFlightList() {
        return flightList;
    }

    public List<FlightPath> findFlightPaths(String departure, String destination, int maxStops, Connection con) throws SQLException {
        List<FlightPath> validPaths = new ArrayList<>();
        findFlightPathsRecursive(departure, destination, maxStops, new FlightPath(), validPaths, con);
        return validPaths;
    }

    private void findFlightPathsRecursive(String currentAirport, String destination, int stopsLeft, FlightPath currentPath, List<FlightPath> validPaths, Connection con) throws SQLException {
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
                    System.out.println(flight);
                    validPaths.add(newPath);
                } else if (stopsLeft > 0) {
                    findFlightPathsRecursive(flight.getArrivalAirport(), destination, stopsLeft - 1, newPath, validPaths, con);
                }
            }
        }
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
