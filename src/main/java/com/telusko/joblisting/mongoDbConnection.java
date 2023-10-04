package com.telusko.joblisting;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

public class mongoDbConnection {
      public static void main(String[] args) {
        try {
            // Replace "your_connection_string" with your actual MongoDB connection string
            MongoClient mongoClient = MongoClients.create("mongodb+srv://amankumartripathi29:beawesome@cluster0.i5ji6yi.mongodb.net/?retryWrites=true&w=majority");

            // If the connection is successful, this line will be executed
            System.out.println("Connected to MongoDB!");
        } catch (Exception e) {
            // If there's an exception, print an error message
            System.err.println("Unable to connect to MongoDB. Error: " + e.getMessage());
        }
    }
}
