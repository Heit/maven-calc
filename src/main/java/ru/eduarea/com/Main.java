package ru.eduarea.com;

import java.util.Scanner;

class Main {

  public static void main(String[] args) throws Exception {
    System.out.println("Interactive calculator started.");
    System.out.println("input \"quit\" to leave program");
    Scanner keyboard = new Scanner(System.in);
    MavenCalcParser parser = new MavenCalcParser();
    while (true) {
      System.out.print("\n> ");
      String input = keyboard.nextLine();
      if (input.equals("quit")) {
        break;
      }
      parser.process(input+"\n");
    }
    System.out.println("\nBye!");
  }
}
