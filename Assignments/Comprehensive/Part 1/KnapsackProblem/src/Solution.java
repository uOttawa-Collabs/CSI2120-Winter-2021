import util.Item;
import util.Knapsack;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * Solution.java
 *
 * @author Xiaoxuan Wang 300133594
 */
public abstract class Solution
{
    private final Item[]   items;
    private       Knapsack knapsack;

    public Solution(Item[] items, Knapsack knapsack)
    {
        this.items    = items;
        this.knapsack = knapsack;
    }

    public Item getItem(int index)
    {
        return items[index];
    }

    public int getItemsLength()
    {
        return items.length;
    }

    public Knapsack getKnapsack()
    {
        return knapsack;
    }

    protected void setKnapsack(Knapsack knapsack) { this.knapsack = knapsack; }

    abstract public void solve();
}
