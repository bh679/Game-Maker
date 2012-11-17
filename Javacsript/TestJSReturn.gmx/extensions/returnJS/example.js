function string_pos_ext(sub, string, offset) {
	return string.indexOf(sub, offset - 1) + 1;
}
function vector_length(x, y) {
	return Math.sqrt(x * x + y * y);
}
function get_null() {
	return null;
}
function get_nothing() {
	return undefined;
}
function compare_strict(a, b) {
	return a === b;
}

function return1()
{
	return 1;
}