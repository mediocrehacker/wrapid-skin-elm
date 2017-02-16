module AddRole exposing (..)

import Html exposing (Html, text, input, div, p)
import Html.Attributes exposing (placeholder, style, value)
import Html.Events exposing (onInput)
import Types exposing (Role)

-- MODEL

type alias Model =
    { roleEditable : RoleEditable
    , amount : Int }

type alias RoleEditable =
    { role : String
    , callStart : String
    , pay: String
    }

init =
    { role = RoleEditable "" "" ""
    , amount = 10 }

-- ACTION, UPDATE

type Msg
    = UpdRole String
    | UpdCallstart String
    | UpdPay String

-- type Filed
--     = .role

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "role msg: " msg of
        UpdRole str ->
            ( { model | role = str }
            , Cmd.none)
        UpdCallstart str ->
            ( { model | callStart = str }
            , Cmd.none)
        UpdPay str ->
            ( { model | pay = str }
            , Cmd.none)
        UpdAmount int ->
            ( model
            , Cmd.none)

-- View


view : Model -> Html Msg
view model =
    div [ ]
        [ p [] [ text "Add Fields"]
        , input [ placeholder "Amount", onInput UpdAmount ] []
        , input [ placeholder "Role", onInput UpdRole, value model.role ] []
        , input [ placeholder "Pay", onInput UpdPay, value model.pay ] []
        , input [ placeholder "Call Start", onInput UpdCallstart, value model.callStart ] []
        ]

-- , input [ placeholder "First", onInput UpdFirst, value model.first ] []
-- , input [ placeholder "Last", onInput UpdLast, value model.last ] []
-- , input [ placeholder "Lunch Start", onInput UpdLunchStart, value model.lunchStart ] []
-- , input [ placeholder "Lunch length", onInput UpdLunchLength, value model.lunchLength ] []
-- , input [ placeholder "In", onInput UpdRoleIn, value model.roleIn ] []
-- , input [ placeholder "Out", onInput UpdRoleOut, value model.roleOut ] []
-- , input [ placeholder "Call End", onInput UpdCallEnd, value model.callEnd ] []
-- , input [ placeholder "Email", onInput UpdEmail, value model.email] []
-- , input [ placeholder "Role", onInput UpdRole, value model.role ] []
