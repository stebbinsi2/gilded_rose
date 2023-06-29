defmodule GildedRoseTest do
  use ExUnit.Case

  test "Once the sell by date has passed, Quality degrades twice as fast" do
    assert GildedRose.update_quality([
             %Item{name: "something", sell_in: 0, quality: 4}
           ]) ==
             [%Item{name: "something", sell_in: -1, quality: 2}]
  end

  test "The Quality of an item is never negative" do
    assert GildedRose.update_quality([
             %Item{name: "something", sell_in: 3, quality: 0}
           ]) ==
             [%Item{name: "something", sell_in: 2, quality: 0}]
  end

  test "Aged Brie actually increases in Quality the older it gets" do
    assert GildedRose.update_quality([
             %Item{name: "Aged Brie", sell_in: 4, quality: 4}
           ]) ==
             [%Item{name: "Aged Brie", sell_in: 3, quality: 5}]
  end

  test "The Quality of an item is never more than 50" do
    assert GildedRose.update_quality([
             %Item{name: "Aged Brie", sell_in: 5, quality: 50}
           ]) ==
             [%Item{name: "Aged Brie", sell_in: 4, quality: 50}]
  end

  test "Sulfuras, Hand of Ragnaros, being a legendary item, never has to be sold or decreases in Quality" do
    assert GildedRose.update_quality([
             %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 5, quality: 80}
           ]) ==
             [%Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 5, quality: 80}]
  end

  test "Backstage passes, like aged brie, increases in Quality as its SellIn value approaches" do
    assert GildedRose.update_quality([
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 20, quality: 5}
           ]) ==
             [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 19, quality: 6}]
  end

  test "Quality increases by 2 when there are 10 days or less" do
    assert GildedRose.update_quality([
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}
           ]) ==
             [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]
  end

  test "Quality increases by 3 when there are 5 days or less" do
    assert GildedRose.update_quality([
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 1}
           ]) ==
             [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 3, quality: 4}]
  end

  test "Quality drops to 0 after the concert" do
    assert GildedRose.update_quality([
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 10}
           ]) ==
             [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -1, quality: 0}]
  end

  test "begin the journey of refactoring" do
    items = [%Item{name: "fixme", sell_in: 0, quality: 0}]
    GildedRose.update_quality(items)
    %{name: firstItemName} = List.first(items)
    assert "fixme" == firstItemName
  end
end
