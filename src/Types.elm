module Types exposing (..)

import Random.Pcg
import Uuid
import Uuid.Barebones
import Random

type alias Role =
    { role : String
    , first : String
    , last : String
    , callStart : String
    , pay: String
    , lunchStart : String
    , lunchLength : String
    , roleIn : String
    , roleOut : String
    , callEnd : String
    , email : String
    , uuid : String
    }

emptyRole : Role
emptyRole =
    Role "" "" "" "" "" "" "" "" "" "" "" uuid

uuid : String
uuid =
    let

        u = Random.
    in
        case Debug.log "u: " u of
            Random.Pcg.Generator uuid ->
                Uuid.toString uuid
            Nothing ->
                "1"


initRoles : List Role
initRoles =
   List.map (\x -> x uuid )
    [ Role "Zombie Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Zombie Super Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Cop Extra" "Peter" "Geit" "9:00 Am" "$ 130/12" "11:00" "1 hr" "" "" "5:00PM" "joshBig@gmail.com"
    , Role "Thief Extra" "Peter" "Geit" "9:00 Am" "$ 145/12" "13:00" "1 hr" "" "" "6:00PM" "joshBIg@gmail.com"
    , Role "Thief Extra" "Max" "Marra" "8:30 Am" "$ 150/6" "14:00" "1 hr" "" "" "8:00PM" "joshSmall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:40 Am" "$ 100/12" "13:30" "1.5 hr" "" "" "7:00PM" "joshTall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:15 Am" "$ 50/12" "14:15" "2 hr" "" "" "5:00PM" "peter@gmail.com"
    ]
