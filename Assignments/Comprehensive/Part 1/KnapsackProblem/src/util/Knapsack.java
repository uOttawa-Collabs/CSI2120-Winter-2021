package util;

import java.util.Arrays;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * Knapsack.java
 *
 * @author Xiaoxuan Wang 300133594
 */
public class Knapsack implements Comparable<Knapsack>
{
    private final int    numberOfItems;
    private final int    maximumCapacity;
    private final Item[] items;
    private       int    itemCount;
    private       int    freeSpace;
    private       int    totalValue;

    public Knapsack(int numberOfItems, int maximumCapacity)
    {
        this.numberOfItems   = numberOfItems;
        this.maximumCapacity = maximumCapacity;

        itemCount  = 0;
        freeSpace  = maximumCapacity;
        totalValue = 0;
        items      = new Item[numberOfItems];
    }

    /**
     * Copy constructor that generates an identical copy of the knapsack
     *
     * @param knapsack Source
     */
    public Knapsack(Knapsack knapsack)
    {
        numberOfItems   = knapsack.numberOfItems;
        maximumCapacity = knapsack.maximumCapacity;

        itemCount  = knapsack.itemCount;
        freeSpace  = knapsack.freeSpace;
        totalValue = knapsack.totalValue;

        items = new Item[numberOfItems];
        System.arraycopy(knapsack.items, 0, items, 0, knapsack.items.length);
    }

    public int getNumberOfItems()
    {
        return numberOfItems;
    }

    public int getMaximumCapacity()
    {
        return maximumCapacity;
    }

    public int getItemCount()
    {
        return itemCount;
    }

    public int getFreeSpace()
    {
        return freeSpace;
    }

    public int getTotalValue()
    {
        return totalValue;
    }

    public int getTotalWeight() { return maximumCapacity - freeSpace; }

    public Item getItem(int index)
    {
        return items[index];
    }

    /**
     * Populate the knapsack with items in another knapsack, in order, as much as possible.
     *
     * @param knapsack Source
     */
    public void populateWith(Knapsack knapsack)
    {
        clear();

        for (int i = 0; i < knapsack.getItemCount(); ++i)
        {
            if (!put(knapsack.getItem(i)))
                return;
        }
    }

    /**
     * Put an item in the knapsack.
     * Reject when the knapsack is full, in terms of either the number of items or the weight.
     *
     * @param item An item
     * @return true if the operation is successful; false otherwise.
     */
    public boolean put(Item item)
    {
        if (itemCount >= numberOfItems || item.getWeight() > freeSpace)
        {
            return false;
        }
        else
        {
            freeSpace -= item.getWeight();
            totalValue += item.getValue();

            items[itemCount++] = item;

            return true;
        }
    }

    /**
     * Pop out the last object put in the knapsack.
     *
     * @return The last object put in the knapsack.
     */
    public Item pop()
    {
        if (itemCount > 0)
        {
            --itemCount;
            freeSpace += items[itemCount].getWeight();
            totalValue -= items[itemCount].getValue();

            return items[itemCount];
        }
        else
            return null;
    }

    /**
     * Empty the knapsack
     */
    public void clear()
    {
        itemCount  = 0;
        freeSpace  = maximumCapacity;
        totalValue = 0;

        Arrays.fill(items, null);
    }

    /**
     * Define the lexicographical precedence of a set of knapsacks as the amount of the the total value in a knapsack.
     *
     * @param knapsack A knapsack
     * @return The lexicographical difference of two knapsacks
     */
    @Override
    public int compareTo(Knapsack knapsack)
    {
        return knapsack.getTotalValue() - getTotalValue();
    }
}
