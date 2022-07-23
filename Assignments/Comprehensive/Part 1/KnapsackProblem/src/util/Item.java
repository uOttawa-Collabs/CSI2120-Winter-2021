package util;

/**
 * CSI2120 - 2021W
 * <p>
 * Comprehensive Assignment Part 1
 * Item.java
 *
 * @author Xiaoxuan Wang 300133594
 */
public class Item implements Comparable<Item>
{
    private final String name;
    private final int    value;
    private final int    weight;
    private final double unitValue;

    public Item(String name, int value, int weight)
    {
        this.name   = name;
        this.value  = value;
        this.weight = weight;

        unitValue = ((double) value) / weight;
    }

    public String getName() { return name; }

    public int getValue()
    {
        return value;
    }

    public int getWeight()
    {
        return weight;
    }

    public double getUnitValue() { return unitValue; }

    @Override
    public int compareTo(Item item)
    {
        return (int) Math.signum(item.getUnitValue() - getUnitValue());
    }
}
