#priority 11000

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;

import loottweaker.LootTweaker;
import loottweaker.LootContext;
import loottweaker.vanilla.loot.LootPool;
import loottweaker.vanilla.loot.LootTable;
import loottweaker.vanilla.loot.Functions;
import loottweaker.vanilla.loot.LootFunction;
import loottweaker.vanilla.loot.Conditions;

import scripts.LootTweakerUtils.Logger;
import scripts.LootTweakerUtils.StringHelper.isEmpty;
import scripts.LootTweakerUtils.StringHelper.isNotEmpty;

zenClass LTUtils {
    zenConstructor(arg as string) {
        this.id = arg;
    }
    val id as string;

    function getTable(tableName as string) as LootTable {
        if (isNotEmpty(tableName)){
            return LootTweaker.getTable(tableName);
        } else return null;
    }

    function getPool(tableName as string, poolName as string) as LootPool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName)) {
            return getTable(tableName).getPool(poolName);
        } else return null;
    }

    function getPool(table as LootTable, poolName as string) as LootPool {
        if (!isNull(table) && isNotEmpty(poolName)) {
            return table.getPool(poolName);
        } else return null;
    }

    function newTable(tableName as string) as LootTable {
        if (isNotEmpty(tableName)) {
            return LootTweaker.newTable(tableName);
            Logger.sendInfo("Created table " + tableName ~ ".");
        } else return null;
    }

    function clearTable(tableName as string) as bool {
        if (isNotEmpty(tableName)) {
            getTable(tableName).clear();
            Logger.sendInfo("Cleared table " + tableName ~ ".");
            return true;
        } else return false;
    }
/*
    function newPool(tableName as string, poolName as string, min as float = 1.0f, max as float = 1.0f, minBonus as float = 1.0f, maxBonus as float = 1.0f) as LootPool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName)) {
            if (!isNull(getTable(tableName))) {
                var table as LootTable = getTable(tableName);
                if (!isNull(table.getPool(poolName))) {
                    return;
                } else {
                    table.addPool(poolName, min, max, minBonus, maxBonus);
                    Logger.sendInfo("Added pool " ~ poolName ~ " for table " ~ tableName ~ ".");
                }
            } else return null;
        } else return null;
    }

    function newPool(table as LootTable, poolName as string, min as float = 1.0f, max as float = 1.0f, minBonus as float = 1.0f, maxBonus as float = 1.0f) as LootPool {
        if (!isNull(table) && isNotEmpty(poolName)) {
            if (!isNull(table.getPool(poolName))) {
                return table.getPool(poolName);
            } else {
                table.addPool(poolName, min, max, minBonus, maxBonus);
                Logger.sendInfo("Added pool " ~ poolName ~ " for table.");
            }
        } else return null;
    }
*/
    function removePool(tableName as string, poolName as string) as bool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName)) {
            if (!isNull(getTable(tableName))) {
                var table as LootTable = getTable(tableName);
                if (!isNull(table.getPool(poolName))) {
                    table.removePool(poolName);
                    Logger.sendInfo("Removed pool " ~ poolName ~ " from table " ~ tableName ~ ".");
                    return true;
                } else return false;
            } else return false;
        } else return false;
    }

    function removePool(table as LootTable, poolName as string) as bool {
        if (!isNull(table) && isNotEmpty(poolName)) {
            if (!isNull(table.getPool(poolName))) {
                table.removePool(poolName);
                Logger.sendInfo("Removed pool " ~ poolName ~ " from table " ~ tableName ~ ".");
                return true;
            } else return false;
        } else return false;
    }

    function getMainPool(tableName as string) as LootPool {
        getTable(tableName).getPool("main");
    }
/*
    function addConditionsToPool(tableName as string, poolName as string, conditions as LootCondition[]) as bool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName) && !isNull(conditions) && conditions.length > 0) {
            //for condition in conditions {
                //if (isNull(condition)) {
                    //return false;
                //}
            //}
            if (!isNull(getTable(tableName))) {
                var table as LootTable = getTable(tableName);
                if (!isNull(table.getPool(poolName))) {
                    var pool as LootPool = table.getPool(poolName);
                    pool.addConditions(conditions);
                    return true;
                } else return false;
            } else return false;
        } else return false;
    }

    function addConditionToPool(tableName as string, poolName as string, condition as LootCondition) as bool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName) && !isNull(condition)) {
            if (!isNull(getTable(tableName))) {
                var table as LootTable = getTable(tableName);
                if (!isNull(table.getPool(poolName))) {
                    var pool as LootPool = table.getPool(poolName);
                    var conditions as LootCondition[] = [condition];
                    pool.addConditions(conditions);
                    return true;
                } else return false;
            } else return false;
        } else return false;
    }

    function addConditionsToPool(table as LootTable, poolName as string, conditions as LootCondition[]) as bool {
        if (!isNull(table) && isNotEmpty(poolName) && !isNull(conditions) && conditions.length > 0) {
            if (!isNull(table.getPool(poolName))) {
                var pool as LootPool = table.getPool(poolName);
                pool.addConditions(conditions);
                return true;
            } else return false;
        } else return false;
    }

    function addConditionToPool(table as LootTable, poolName as string, condition as LootCondition) as bool {
        if (!isNull(table) && isNotEmpty(poolName) && !isNull(condition)) {
            if (!isNull(table.getPool(poolName))) {
                var pool as LootPool = table.getPool(poolName);
                var conditions as LootCondition[] = [condition];
                    pool.addConditions(conditions);
                    return true;
            } else return false;
        } else return false;
    }

    function addConditionsToPool(pool as LootPool, conditions as LootCondition[]) as bool {
        if (!isNull(pool) && !isNull(conditions) && conditions.length > 0) {
            pool.addConditions(conditions);
            return true;
        } else return false;
    }

    function addConditionToPool(pool as LootPool, condition as LootCondition) as bool {
        if (!isNull(pool) && !isNull(conditions)) {
            var conditions as LootCondition[] = [condition];
                pool.addConditions(conditions);
                return true;
        } else return false;
    }

    function addConditionsToPool(pool as LootPool, conditions as LootCondition[]) as bool {
        if (!isNull(pool) && !isNull(conditions) && conditions.length > 0) {
            pool.addConditions(conditions);
            return true;
        } else return false;
    }

    function addConditionToPool(pool as LootPool, condition as LootCondition) as bool {
        if (!isNull(pool) && !isNull(condition)) {
            var conditions as LootCondition[] = [condition];
            pool.addConditions(conditions);
            return true;
        } else return false;
    }
*//*
    function removeEntriesFromPool(tableName as string, poolName as string, entryNames as string[]) as bool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName) && entryNames.length > 0) {
            if (!isNull(getTable(tableName))) {
                var table as LootTable = getTable(tableName);
                if (!isNull(table.getPool(poolName))) {
                    var pool as LootPool = table.getPool(poolName);
                    for entryName in entryNames {
                        if (isNotEmpty(entryName)){
                            pool.removeEntry(entryName);
                        } else return false;
                    }
                    return true;
                } else return false;
            } else return false;
        } else return false;
    }

    function removeEntryFromPool(tableName as string, poolName as string, entryName as string) as bool {
        if (isNotEmpty(tableName) && isNotEmpty(poolName) && !isNotEmpty(entryName)) {
            if (!isNull(getTable(tableName))) {
                var table as LootTable = getTable(tableName);
                if (!isNull(table.getPool(poolName))) {
                    var pool as LootPool = table.getPool(poolName);
                    pool.removeEntry(entryName);
                    return true;
                } else return false;
            } else return false;
        }
    }

    function removeEntriesFromPool(table as LootTable, poolName as string, entryNames as string[]) as bool {
        if (!isNull(table) && isNotEmpty(poolName) && entryNames.length > 0) {
            if (!isNull(table.getPool(poolName))) {
                var pool as LootPool = table.getPool(poolName);
                for entryName in entryNames {
                    if (isNotEmpty(entryName)) {
                        pool.removeEntry(entryName);
                    } else return false;
                }
                return true;
            } else return false;
        } else return false;
    }

    function removeEntryFromPool(table as LootTable, poolName as string, entryName as string) as bool {
        if (!isNull(table) && isNotEmpty(poolName) && !isNotEmpty(entryName)) {
            if (!isNull(table.getPool(poolName))) {
                var pool as LootPool = table.getPool(poolName);
                pool.removeEntry(entryName);
                return true;
            } else return false;
        } else return false;
    }

    function removeEntriesFromPool(pool as LootPool, entryNames as string[]) as bool {
        if (!isNull(pool) && entryNames.length > 0) {
            for entryName in entryNames {
                if (isNotEmpty(entryName)) {
                    pool.removeEntry(entryName);
                } else return false;
            }
            return true;
        } else return false;
    }

    function removeEntryFromPool(pool as LootPool, entryName as string) as bool {
        if (!isNull(pool) && !isNotEmpty(entryName)) {
            pool.removeEntry(entryName);
            return true;
        } else return false;
    }

    function removeEntriesFromPool(pool as LootPool, entryNames as string[]) as bool {
        if (!isNull(pool) && entryNames.length > 0) {
            for entryName in entryNames {
                if (isNotEmpty(entryName)) {
                    pool.removeEntry(entryName);
                } else return false;
            }
            return true;
        } else return false;
    }

    function removeEntryFromPool(pool as LootPool, entryName as string) as bool {
        if (!isNull(pool) && !isNotEmpty(entryName)) {
            if (isNotEmpty(entryName)) {
                pool.removeEntry(entryName);
            } else return false;
        } else return false;
    }*/
}
