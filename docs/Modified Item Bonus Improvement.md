# How Item Bonus Improvement works

There is a table for value and time by rarity on page 15 of Artificers Guide to Magic Items:

### Table 1

| Item Rarity | Workweeks | Cost        | Minimum Level |
| ----------- | --------- | ----------- | ------------- |
| Common      | 1         | 50 GP       | 3rd           |
| Uncommon    | 2         | 200 GP      | 3rd           |
| Rare        | 10        | 2,000 GP    | 6th           |
| Very Rare   | 25        | 20,000 GP   | 11th          |
| Legendary   | 50+       | 100,000+ GP | 17th          |

The section on Item Bonus Improvement basically says, take this table and adjust the values, based on the character doing the crafting:

### Table 2

| Crafter Type                           | Modifier |
| -------------------------------------- | -------- |
| Crafter (Any PC crafter/non-Artificer) | 15%      |
| Artificer (non-speciality)             | 25%      |
| Artificer (speciality)                 | 35%      |

The only relevant rows of Table 1 are Rare, Very Rare and Legendary, because you use the row for the rarity of the finished product (note, the starting item must be at least +1), and rarity by item bonus is:

### Table 3

| Rarity    | Ammunition | Armor | Rod | Shield | Weapon |
| --------- | ---------- | ----- | --- | ------ | ------ |
| Uncommon  | +1         |       | +1  | +1     | +1     |
| Rare      | +2         | +1    | +2  | +2     | +2     |
| Very Rare | +3         | +2    | +3  | +3     | +3     |
| Legendary |            | +3    |     |        |        |

The rationale for this approach, which is different from item enchantment, is because it should be faster to improve an existing magic item than it is to create one from scratch.  I'm not sure I agree with the premise, but whatever.

# How Item Enchantment works

Follow these steps:

1. Determine the cost of the final product.  Table 1 can be used for this, or the DMs Guide, or the DM can just make it up.
2. Determine the GP value generated per work week.  This is determined by the Artificer, any assistants, and the quality of the tools used.
3. Divide the cost of the item by the weekly GP value, and get the Base WorkWeeks required.
4. Determine the WorkWeek Modifier based on the crafting environment.
5. Adjust the Base WorkWeeks by the WorkWeek Modifier, to get the Adjusted WorkWeeks.
6. Determine the value provided (in hours) of any magical components you are using to create the item, including spells cast on the item during construction.
7. Subtract the component value from Adjusted WorkWeeks, and that gives you the actual time taken.
8. Calculate your costs by multiplying the actual time taken by your assistant costs.

The actual time taken is the critical value.

# My suggestion

The Workweeks to Cost ratio in Table 1 is way off for the Rare-Legendary ranks.  Rare assumes the crafter produces 200 GP of value per week, which is twice what a specialist artificer actually produces, and it only goes up from there.  Very Rare assumes 800 GP per week, and Legendary assumes 2,000 GP.  This tells me that the crafter cannot possibly be working alone.

So, we keep the Workweeks column of Table 1, and recalculate the GP column based on the assumption that an lone, specialized Artificer is doing the work with no special tools.  That produces:

### Table 4

| Item Rarity | Workweeks | Creation Cost | Minimum Level |
| ----------- | --------- | ------------- | ------------- |
| Common      | 1         | 100 GP        | 3rd           |
| Uncommon    | 2         | 200 GP        | 3rd           |
| Rare        | 10        | 1,000 GP      | 6th           |
| Very Rare   | 25        | 2,500 GP      | 11th          |
| Legendary   | 50+       | 5,000+ GP     | 17th          |

We use the cost from Table 4 as the input to the standard Item Enchantment process.  We then multiply the actual time taken (step 7) by the modifier from Table 2.  This will produce exactly the same result as the current process for a lone specialized Artificer using no special tools.  Unspecialized Artificers and crafters costs will increase. To offset that, assistants, tools and working environment modifiers can reduce the totals.