import util.Item;
import util.Knapsack;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * BruteforceSolution.java
 *
 * @author Xiaoxuan Wang 300133594
 */
public class BruteforceSolution extends Solution
{
    private final Knapsack knapsack;

    public BruteforceSolution(Item[] items, Knapsack knapsack)
    {
        super(items, knapsack);
        this.knapsack = new Knapsack(items.length, getKnapsack().getMaximumCapacity());
    }

    @Override
    public void solve()
    {
        recursion(0);
    }

    private void recursion(int index)
    {
        if (index < getItemsLength())
        {
            // Try to put next item into the knapsack
            boolean success = knapsack.put(getItem(index));

            /*
             * For this recursion:
             *
             * If success == true, then we are going in the left branch of the binary tree
             *     i.e. we put the item into the current knapsack
             *
             * If success == false, then we are directly going in the right branch of the binary tree, skipping the left branch
             *     i.e. we skipped the item
             */
            recursion(index + 1);

            if (success)
            {
                /*
                 * The fact that success == true indicated we went through the left branch without skipping it.
                 *
                 * Therefore, we have to pop out the last item that was added into the current knapsack.
                 * After that, we are ready to enter the right branch to ensure the whole binary tree is explored.
                 */
                knapsack.pop();
                recursion(index + 1);
            }
        }
        else if (knapsack.getTotalValue() > getKnapsack().getTotalValue())
        {
            /*
             * The branch is executed when
             *     1. index >= getItems().length, i.e. we have reached a leaf in the binary tree;
             *     2. Current knapsack is more valuable.
             *
             * We update the result knapsack.
             * By using the copy constructor of the Knapsack class, we ensured the result knapsack is independent from current knapsack.
             */
            setKnapsack(new Knapsack(knapsack));
        }
    }
}
