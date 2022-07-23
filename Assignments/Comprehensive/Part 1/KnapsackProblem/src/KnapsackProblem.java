import util.Item;
import util.Knapsack;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * KnapsackProblem.java - Program entry point
 *
 * @author Xiaoxuan Wang 300133594
 */
public class KnapsackProblem
{
    public static void main(String[] args)
    {
        try
        {
            if (args.length < 2)
            {
                System.err.println("Usage: java KnapsackProblem <inputFilePath> <flag>");
            }
            else
            {
                // Generate output file path
                String  outputFilePath;
                Matcher matcher = Pattern.compile("(.+)\\..+").matcher(args[0]);
                if (matcher.find())
                    outputFilePath = matcher.group(1) + ".sol";
                else
                    outputFilePath = args[0] + ".sol";

                // Read command line arguments and open file reader
                BufferedReader reader = new BufferedReader(new FileReader(args[0]));
                char           flag   = Character.toUpperCase(args[1].charAt(0));

                // Parse information about items
                int    numberOfItems = Integer.parseInt(reader.readLine().split(" ")[0]);
                Item[] items         = new Item[numberOfItems];

                for (int i = 0; i < numberOfItems; ++i)
                {
                    String[] tokens = reader.readLine().strip().split(" ");

                    String name  = tokens[0];
                    int    value = 0, weight = 0;

                    int j = 1;
                    while (j < tokens.length)
                    {
                        if (!tokens[j].isEmpty())
                        {
                            value = Integer.parseInt(tokens[j]);
                            ++j;
                            break;
                        }
                        ++j;
                    }
                    while (j < tokens.length)
                    {
                        if (!tokens[j].isEmpty())
                        {
                            weight = Integer.parseInt(tokens[j]);
                            break;
                        }
                        ++j;
                    }

                    items[i] = new Item(name, value, weight);
                }

                // Parse knapsack size
                int      knapsackSize = Integer.parseInt(reader.readLine());
                Knapsack knapsack     = new Knapsack(numberOfItems, knapsackSize);

                // Solve the problem
                Solution solution;

                switch (flag)
                {
                    case 'D':
                        solution = new DynamicProgrammingSolution(items, knapsack);
                        break;
                    case 'F':
                        solution = new BruteforceSolution(items, knapsack);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown method flag. Only D and F are supported");
                }

                solution.solve();

                // Write result
                PrintWriter writer = new PrintWriter(new FileWriter(outputFilePath));
                writer.println(solution.getKnapsack().getTotalValue());

                Knapsack solutionKnapsack = solution.getKnapsack();
                writer.print(solutionKnapsack.getItem(0).getName());
                for (int i = 1; i < solution.getKnapsack().getItemCount(); ++i)
                     writer.printf("%3s", solutionKnapsack.getItem(i).getName());
                writer.println();
                writer.close();
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
