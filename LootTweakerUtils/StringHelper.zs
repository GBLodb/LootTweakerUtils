#priority 11001

function isEmpty(input as string) as bool {
    if (isNull(input) && input.length <= 0) {
        return true;
    } else return false;
}

function isNotEmpty(input as string) as bool {
        return !isEmpty(input);
}
