port module Main exposing (main)

import AddRoles as AddRoles
import Types exposing (Role, initRoles, addIdToRoles, roleToString)
import Html exposing (Html, Attribute, a, button, div, h1, img, li, p, text, ul, input)
import Html.Attributes exposing (href, src, placeholder, style, checked, type_)
import Html.Events exposing (onClick, onInput, onCheck)
import Navigation as Nav
import List.Extra exposing (find)
import WrapidLogo exposing (logo)
import Maybe exposing (andThen)
import Table exposing (defaultCustomizations)

main : Program Never Model Msg
main =
    Nav.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- MODEL


type alias Model =
    { history : List Nav.Location
    , profiles : List Profile
    , currentImg : Maybe String
    , addRoles : AddRoles.Model
    , roles : List Role
    , tableState : Table.State
    , query : String
    , dialogOpened : Dialog
    }


type alias Url =
    String


type alias Profile =
    { id : String
    , firstName : String
    , url : Maybe String
    }


initModel : Nav.Location -> Model
initModel location =
    Model [ location ] [] Nothing  AddRoles.init initRoles (Table.initialSort "Role") "" NoDialog

init : Nav.Location -> (Model, Cmd Msg)
init location =
    ( initModel location, Cmd.none )


-- UPDATE


type Msg
    = UrlChange Nav.Location
    | ShowAvatar String
    | SetQuery String
    | ToggleSelected String
    | ToggleSelectedAll Bool
    | SetTableState Table.State
    | ToggleDialog Dialog
    | AddRoles
    | EditRoles String
    | AddRolesMsg AddRoles.Msg

type Dialog
    = AddDialog
    | EditDialog
    | NoDialog

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg: " msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )

        SetQuery newQuery ->
            ( { model | query = newQuery }
            , Cmd.none )

        ToggleDialog dialog ->
            let
                toggleDialog = if dialog == model.dialogOpened then NoDialog else dialog
            in
                ( { model | dialogOpened = toggleDialog }
                , Cmd.none )


        ShowAvatar id ->
            let
                clickedUser =
                    find (\usr -> usr.id == id) model.profiles

                url =
                    andThen .url clickedUser
            in
                ( { model | currentImg = url }
                , Cmd.none
                )

        ToggleSelected id ->
            ( { model | roles = List.map (toggle id) model.roles }
            , Cmd.none
            )

        ToggleSelectedAll bool ->
            ( { model | roles = toggleAll bool model.roles }
            , Cmd.none
            )

        SetTableState newState ->
            ( { model | tableState = newState }
            , Cmd.none
            )


        AddRolesMsg subMsg ->
                let
                    _ = Debug.log "model: " model
                    ( updatedAddRolesModel, addRolesCmd ) =
                        AddRoles.update subMsg model.addRoles
                in
                    ( { model | addRoles = updatedAddRolesModel }
                    , Cmd.map AddRolesMsg addRolesCmd
                    )

        AddRoles ->
            let
                rs = addIdToRoles (model.roles ++ AddRoles.toRoles(model.addRoles))
            in
                ( { model | roles = rs }
                , Cmd.none
                )

        EditRoles string->
            let
                -- updateRoles = { x | role = string }
                updateRoles = List.map
                     (\x -> if x.selected == True then
                                { x | role = string  }
                            else
                                x
                     )
                     model.roles

            in
                ( { model | roles = updateRoles }
                , Cmd.none
                )

        -- _ ->
        --     (model, Cmd.none)


toggleAll : Bool -> List Role -> List Role
toggleAll bool roles =
    List.map (\x -> { x | selected = bool }) roles



toggle : String -> Role -> Role
toggle id role =
  if role.id == id then
    { role | selected = not role.selected }

  else
    role

-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ -- logo
        h1 [] [ text "Pages" ]
        , ul [] (List.map viewLink [ "bears", "cats", "dogs", "elephants", "fish" ])
        , h1 [] [ text "History" ]
        , ul [] (List.map viewLocation model.history)
        , h1 [] [ text "Data" ]
        , viewAddRoles model.dialogOpened model.addRoles
        , viewTableWithSearch model.roles model.tableState model.query
        , viewAvatar model.currentImg
        ]

viewAddRoles : Dialog -> AddRoles.Model -> Html Msg
viewAddRoles dialog addRolessModel =
    case dialog of
        AddDialog ->
            div []
                [ Html.map AddRolesMsg (AddRoles.view addRolessModel)
                , button [ onClick AddRoles ] [ text "ADD ROLES" ]
                ]

        EditDialog ->
            viewEditRoles

        _ ->
            div [] []


viewEditRoles : Html Msg
viewEditRoles  =
    div []
        [ text "Edit Role"
        , input [ placeholder "Edit Role", onInput EditRoles ] []
        ]


viewTableWithSearch : List Role -> Table.State -> String -> Html Msg
viewTableWithSearch roles tableState query =
    let
        lowerQuery =
            String.toLower query

        acceptableRole =
            List.filter (String.contains lowerQuery << String.toLower << roleToString) roles
        checkedAll =
            List.all (\x -> x.selected == True) roles

    in
        div []
            [ input [ placeholder "Search by Role", onInput SetQuery ] []
            , button [ onClick (ToggleDialog AddDialog) ] [ text "ADD" ]
            , button [ onClick (ToggleDialog EditDialog) ] [ text "EDIT" ]
            , input [ type_ "checkbox", onCheck ToggleSelectedAll, checked checkedAll ] []
            , viewTable tableState acceptableRole
            ]


viewTable : Table.State -> List Role -> Html Msg
viewTable tableState roles =
    Table.view config tableState roles

config : Table.Config Role Msg
config =
  Table.customConfig
    { toId = .id
    , toMsg = SetTableState
    , columns =
        [ checkboxColumn
        , Table.stringColumn "Id" .id
        , Table.stringColumn "Role" .role
        , Table.stringColumn "First" .first
        , Table.stringColumn "Last" .last
        , Table.stringColumn "Call Start" .callStart
        , Table.stringColumn "Pay" .pay
        , Table.stringColumn "Lunch Start" .lunchStart
        , Table.stringColumn "Lunch length" .lunchLength
        , Table.stringColumn "In" .roleIn
        , Table.stringColumn "Out" .roleOut
        , Table.stringColumn "Call End" .callEnd
        , Table.stringColumn "Email" .email
        ]
    , customizations =
        { defaultCustomizations | rowAttrs = toRowAttrs }
    }

checkboxColumn : Table.Column Role Msg
checkboxColumn =
  Table.veryCustomColumn
    { name = ""
    , viewData = viewCheckbox
    , sorter = Table.unsortable
    }

viewCheckbox : Role -> Table.HtmlDetails Msg
viewCheckbox {selected} =
  Table.HtmlDetails []
    [ input [ type_ "checkbox", checked selected ] []
    ]


toRowAttrs : Role -> List (Attribute Msg)
toRowAttrs role =
  [ onClick (ToggleSelected role.id)
  , style [ ("background", if role.selected then "#CEFAF8" else "white") ]
  ]

viewLink : String -> Html msg
viewLink name =
    li [] [ a [ href ("#" ++ name) ] [ text name ] ]


viewLocation : Nav.Location -> Html msg
viewLocation location =
    li [] [ text (location.pathname ++ location.hash) ]



viewAvatar : Maybe String -> Html msg
viewAvatar url =
    case url of
        Nothing ->
            text ""

        Just loc ->
            img [ src loc ] []



-- PORTS


-- SUBSCRIPTIONS


-- Skin Date

-- Action TOP
-- Search
-- Edit
-- Add

-- Action Bottom
-- Breakdown
-- Export CSV
-- Wrap Skin
