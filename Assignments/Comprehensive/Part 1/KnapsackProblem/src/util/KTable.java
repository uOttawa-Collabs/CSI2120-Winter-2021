package util;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * KTable.java
 *
 * @author Xiaoxuan Wang 300133594
 */
public class KTable
{
    private final Knapsack[][] knapsacks;

    public KTable(int row, int column)
    {
        knapsacks = new Knapsack[row][column];

        // Initialization
        for (int i = 0; i < knapsacks.length; ++i)
            for (int j = 0; j < knapsacks[i].length; ++j)
                 knapsacks[i][j] = new Knapsack(row - 1, j);
    }

    public Knapsack getKnapsack(int row, int column)
    {
        return knapsacks[row][column];
    }

    public int getRowCount()    { return knapsacks.length; }

    public int getColumnCount() { return knapsacks[0].length; }
}
