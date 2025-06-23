#include <string.h>
#include "pwd_checker.h"

/*
Password checker

Requirements:
- Password must be at least 10 characters
- Password must contain at least
    - 1 upper case letter
    - 1 lower case letter
    - 1 number
- Password cannot contain the person's first name or last name (case sensitive)

For the simplicity of this exercise:
- This is not the most efficient way to implement this program
- These functions do not perform any error checking
- You can assume that the first and last name will never be the empty string
*/

/* Returns true if the length of PASSWORD is at least 10, false otherwise */
bool check_length(const char *password)
{
    int length = strlen(password);
    bool meets_len_req = (length >= 10); // Fixed: changed <= to >=
    return meets_len_req;
}

/* Returns true if LETTER is in the range [LOWER, UPPER], false otherwise */
bool check_range(char letter, char lower, char upper)
{
    bool is_in_range = (letter >= lower && letter <= upper); //  Fixed: made comparison inclusive
    return is_in_range;
}

/* Returns true if PASSWORD contains at least one upper case letter, false otherwise */
bool check_upper(const char *password)
{
    while (*password != '\0')
    { //  Fixed: properly dereferencing pointer
        bool is_in_range = check_range(*password, 'A', 'Z');
        if (is_in_range)
        {
            return true;
        }
        ++password;
    }
    return false;
}

/* Returns true if PASSWORD contains at least one lower case letter, false otherwise */
bool check_lower(const char *password)
{
    while (*password != '\0')
    {
        bool is_in_range = check_range(*password, 'a', 'z');
        if (is_in_range)
        {
            return true;
        }
        ++password;
    }
    return false;
}

/* Returns true if PASSWORD contains at least one number, false otherwise */
bool check_number(const char *password)
{
    while (*password != '\0')
    { // Fixed: properly dereferencing pointer
        if (check_range(*password, '0', '9'))
        { // Fixed: pass char, not pointer; use character literals
            return true;
        }
        ++password;
    }
    return false;
}

/* Returns true if the person's first and last name are NOT in the password, false otherwise */
bool check_name(const char *first_name, const char *last_name, const char *password)
{
    const char *first = strstr(password, first_name); // Fixed: removed invalid dereference
    const char *last = strstr(password, last_name);
    return !(first || last); // Fixed: password is valid only if both names are NOT found
}

/* Returns true if PASSWORD meets the conditions specified above */
bool check_password(const char *first_name, const char *last_name, const char *password)
{
    bool length, upper, lower, number, name;
    lower = check_lower(password);
    length = check_length(password);
    name = check_name(first_name, last_name, password);
    number = check_number(password);
    upper = check_upper(password);
    return (lower && length && name && upper && number);
}
