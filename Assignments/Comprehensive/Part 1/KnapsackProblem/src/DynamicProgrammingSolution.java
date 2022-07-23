import util.Item;
import util.KTable;
import util.Knapsack;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * DynamicProgrammingSolution.java
 *
 * @author Xiaoxuan Wang 300133594
 */
public class DynamicProgrammingSolution extends Solution
{
    private final KTable kTable;

    public DynamicProgrammingSolution(Item[] items, Knapsack knapsack)
    {
        super(items, knapsack);
        kTable = new KTable(items.length + 1, knapsack.getMaximumCapacity() + 1);
    }

    @Override
    public void solve()
    {
        // Since the first row and the first column of KTable are empty knapsack, we could start with i = 1 and j = 1
        for (int i = 1; i < kTable.getRowCount(); ++i)
        {
            Item item = getItem(i - 1);

            for (int j = 1; j < kTable.getColumnCount(); ++j)
            {
                // Get the above knapsack
                Knapsack knapsackAbove = kTable.getKnapsack(i - 1, j);

                // The item cannot be fit into knapsackAbove
                if (item.getWeight() > knapsackAbove.getMaximumCapacity())
                    // Populate current knapsack with items contained in knapsackAbove
                    kTable.getKnapsack(i, j).populateWith(knapsackAbove);
                else
                {
                    // Create a new knapsack and populate it with knapsack at (i - 1, j - w_i)
                    Knapsack newKnapsack = new Knapsack(knapsackAbove.getNumberOfItems(), knapsackAbove.getMaximumCapacity());
                    newKnapsack.populateWith(kTable.getKnapsack(i - 1, j - item.getWeight()));
                    // Put the item into the knapsack
                    newKnapsack.put(item);
                    // Populate current knapsack with the knapsack with more value
                    kTable.getKnapsack(i, j).populateWith(compareAndReturn(knapsackAbove, newKnapsack));
                }

                // Set the result knapsack if the current knapsack is more valuable
                Knapsack knapsack;
                if ((knapsack = kTable.getKnapsack(i, j)).getTotalValue() > getKnapsack().getTotalValue())
                    setKnapsack(knapsack);
            }
        }
    }

    /**
     * Compare two object lexicographically and return the one that has higher precedence.
     *
     * @param object1 An object that is of type T
     * @param object2 An object that is of type T
     * @param <T> A Class that implemented Comparable interface
     * @return The object that has higher precedence
     */
    private <T extends Comparable<T>> T compareAndReturn(T object1, T object2)
    {
        return object1.compareTo(object2) < 0 ? object1 : object2;
    }
}
