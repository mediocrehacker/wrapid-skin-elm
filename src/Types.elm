module Types exposing (..)

type alias Role =
    { role : String
    , first : String
    , last : String
    , callStart : String
    , pay: String
    , lunch_start : String
    , lunch_length : String
    , roleIn : String
    , roleOut : String
    , call_end : String
    , email : String
    }

emptyRole : Role
emptyRole =
    Role "" "" "" "" "" "" "" "" "" "" ""

initRoles : List Role
initRoles =
    [ Role "Zombie Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Zombie Super Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Cop Extra" "Peter" "Geit" "9:00 Am" "$ 130/12" "11:00" "1 hr" "" "" "5:00PM" "joshBig@gmail.com"
    , Role "Thief Extra" "Peter" "Geit" "9:00 Am" "$ 145/12" "13:00" "1 hr" "" "" "6:00PM" "joshBIg@gmail.com"
    , Role "Thief Extra" "Max" "Marra" "8:30 Am" "$ 150/6" "14:00" "1 hr" "" "" "8:00PM" "joshSmall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:40 Am" "$ 100/12" "13:30" "1.5 hr" "" "" "7:00PM" "joshTall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:15 Am" "$ 50/12" "14:15" "2 hr" "" "" "5:00PM" "peter@gmail.com"
    ]
