package br.com.ucsal.projetofinal.testcode;

import java.io.File;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        TestResult tr1 = new TestService().executetest(
                """        
                public class Main {
                    public static void main(String args[]){
                        System.out.println("Exemplo 1 ");
                    }
                }
                """, "Main.java", "",null,null);
        System.out.println(tr1);

        TestResult tr2 = new TestService().executetest(
                """
                public class Main {
                    public static void main(String args[]){
                        System.out.println("Exemplo 1 ");
                    }
                }
                """, "Main.java", "",null,new String[]{"Exemplo 1"});
        System.out.println(tr2);


        TestResult tr3 = new TestService().executetest(
                """
                public class Programa {
                    public static void main(String args[]){
                        System.out.println("1");
                    }
                }
                """, "Programa.java", "",null,new String[]{"1"});
        System.out.println(tr3);


        TestResult tr4 = new TestService().executetest(
                """
                                        
                        import java.util.Scanner; 
                                        
                                        
                        public class Programa {
                            
                            public static void main(String args[]){
                            
                            Scanner scanner = new Scanner(System.in);
                            String[] soma = scanner.nextLine().split(" ");
                            int total = 0;
                            for (String s: soma ) {
                                total += Integer.parseInt(s);
                            }
                            System.out.println(total);
                            scanner.close();
                            
                            }
                        }
                        """, "Programa.java", "",new String[]{"1 2 3 4"},new String[]{"10"});
        System.out.println(tr4);


    TestResult tr5 = new TestService().executetest(
            """
                                    
                    import java.util.Scanner; 
                                    
                                    
                    public class Programa {
                        
                        public static void main(String args[]){
                        
                        Scanner scanner = new Scanner(System.in);
                        String[] soma = scanner.nextLine().split(" ");
                        int total = 0;
                        for (String s: soma ) {
                            total += Integer.parseInt(s);
                        }
                        System.out.println(total);
                        scanner.close();
                        
                        }
                    }
                    """, "Programa.java", "",new String[]{"1 2 3 4", "1 2 3 0"},new String[]{"10","6"});
            System.out.println(tr5);

        TestResult tr6 = new TestService().executetest(
                """
                                        
                        import java.util.Scanner; 
                                        
                                        
                        public class Eco {
                            
                            public static void main(String args[]){
                            
                            Scanner scanner = new Scanner(System.in);
                            String p = scanner.nextLine();
                            System.out.println(p);
                            String s = scanner.nextLine();
                            System.out.println(s);
                            String t = scanner.nextLine();
                            System.out.println(t);                            
                            scanner.close();
                            
                            }
                        }
                        """, "Eco.java", "",new String[]{"5\n4\n3\n"},new String[]{"5\n4\n3"});
        System.out.println(tr6);
    }
}