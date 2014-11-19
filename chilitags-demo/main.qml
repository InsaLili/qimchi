import QtQuick 2.3
import QtQuick.Window 2.0
import QtMultimedia 5.1
import QtQuick.Controls 1.0
import Chilitags 1.0
import "Global.js" as Global
import "Coordinates.js" as Coordinates

//We decide which language to use
//import "StringFr.js" as Str
import "StringEn.js" as Str

ApplicationWindow {
    visible: true
    //visibility: "FullScreen"
    color: "black"
    //Settings for a "normal" window
    width: 1280
    height: 960
    title: qsTr("Hello World")


    //There is a display problem with this menubar that sometimes doesn't show anything
    //I don't understand where it comes from
    menuBar: MenuBar {
        Menu {
            title: qsTr(Str.file)
            //*
            MenuItem {
                text: Str.start
                onTriggered: camera.start()
            }
            MenuItem {
                text: Str.stop
                onTriggered: camera.stop()
            }
            MenuItem {
                text: Str.reset
                onTriggered: {
                    main.state = "INITIAL"
                    ch1.visible = false
                    ch2.visible = false
                    ch3.visible = false
                    ch4.visible = false
                    ch5.visible = false
                    ch6.visible = false
                    ch7.visible = false
            }
            }
            //*/
            MenuItem {
                text: Str.exit
                visible:true
                onTriggered: Qt.quit();
            }
        }
    }

    // Simple use the standard QML camera for video input
    Camera { id: camera }

    // Set up chilitag detection
    ChilitagsDetection {
        id: detection

        // Use the camera defined above
        source: camera

        // Define here tagCenter as the center of a 20x20 (mm) tag
        property vector3d tagCenter : Qt.vector3d(10,10,0)

        // We declare tags for the function cards
        // When this card appears we reveals the new constructions
        // If the five possibilities have been found we change state to
        // continue the exercise on the right side
        ChilitagsObject {
            id: constructionCardRecto
            name: "tag_0"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(constructionCardVerso.visible & constructionCardRecto.visible){
                    if(main.state === "CONSTRUCTION_LEFT"){
                        componentbox.flip()
                    }
                    if(main.state === "CONSTRUCTION_RIGHT"){
                        radicalbox.flip()
                    }
                }
            }
        }
        ChilitagsObject {
            id: constructionCardVerso
            name: "tag_1"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(constructionCardVerso.visible & constructionCardRecto.visible){
                    if(main.state === "CONSTRUCTION_LEFT"){
                        componentbox.flip()
                    }
                    if(main.state === "CONSTRUCTION_RIGHT"){
                        radicalbox.flip()
                    }
                }
            }
        }

        ChilitagsObject {
            id: wordCombinationCard
            name: "tag_2"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: pinyinCard
            name: "tag_3"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: startCard
            name: "tag_5"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(main.state == "INITIAL"){
                    if(startCard.visible){
                        main.state = "CONSTRUCTION_LEFT"
                    }
                }
            }
        }
        ChilitagsObject {
            id: resetCard
            name: "tag_6"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(resetCard.visible){
                    main.state = "INITIAL"
                    ch1.visible = false
                    ch2.visible = false
                    ch3.visible = false
                    ch4.visible = false
                    ch5.visible = false
                    ch6.visible = false
                    ch7.visible = false
                    componentbox.component1_constructed = false
                    componentbox.component2_constructed = false
                    componentbox.component3_constructed = false
                    componentbox.component4_constructed = false
                    componentbox.component5_constructed = false
                    componentbox.component6_constructed = false
                    componentbox.component7_constructed = false
                    componentbox.component8_constructed = false
                    radicalbox.radical1_constructed = false
                    radicalbox.radical2_constructed = false
                    radicalbox.radical3_constructed = false
                    radicalbox.radical4_constructed = false
                    radicalbox.radical5_constructed = false
                    radicalbox.radical6_constructed = false
                    radicalbox.radical7_constructed = false
                    radicalbox.radical8_constructed = false
                    mistakes.count = 0
                }
            }
        }
        ChilitagsObject {
            id: switchToComponent
            name: "tag_7"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(main.state == "CONSTRUCTION_RIGHT"){
                    if(switchToComponent.visible){
                        main.state = "CONSTRUCTION_LEFT"
                    }
                }
            }
        }

        ChilitagsObject {
            id: switchToRadicals
            name: "tag_8"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(main.state == "CONSTRUCTION_LEFT"){
                    if(switchToRadicals.visible){
                        main.state = "CONSTRUCTION_RIGHT"
                    }
                }
            }
        }

        // We declare tags for the components (orange cards)
        // We use the onVisibilityChanged method to change the display
        ChilitagsObject {
            id: component1
            name: "tag_104"
            property string character : "子"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component2
            name: "tag_105"
            property string character : "生"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component3
            name: "tag_106"
            property string character : "且"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component4
            name: "tag_107"
            property string character : "也"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component5
            name: "tag_108"
            property string character : "西"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component6
            name: "tag_109"
            property string character : ""
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component7
            name: "tag_110"
            property string character : ""
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: component8
            name: "tag_111"
            property string character : ""
            property vector3d center : transform.times(parent.tagCenter)
        }


        //We declare the tags for the radicals selector
        ChilitagsObject {
            id: selectorTopLeft
            name: "tag_167"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: selectorTopRight
            name: "tag_168"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: selectorBottomLeft
            name: "tag_170"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: selectorBottomRight
            name: "tag_169"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: selectorCursor
            name: "tag_171"
            property vector3d center : transform.times(parent.tagCenter)
            onVisibilityChanged: {
                if(main.state == "LEFT_COMPLETED"){
                    if(selectorCursor.visible){
                        main.state = "CONSTRUCTION_RIGHT"
                        console.log("selectorCursor visible")
                    }
                }
            }
        }



        // We declare tags for the basic sheet
        ChilitagsObject {
            id: sheetTopLeft
            name: "tag_100"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: sheetTopRight
            name: "tag_101"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: sheetBottomRight
            name: "tag_102"
            property vector3d center : transform.times(parent.tagCenter)
        }
        ChilitagsObject {
            id: sheetBottomLeft
            name: "tag_103"
            property vector3d center : transform.times(parent.tagCenter)
        }


    }

    // This Item is the main graphic container, where AR happens.
    // Inside this item, coordinates are in the input image referential,
    // i.e. in pixels, where 0,0 is the top left corner of the video
    Item {
        id: main

        // Reduce everything inside to half size.
        transform: Scale {xScale: .5; yScale:.5}

        state: "INITIAL"

        //We define states for the different parts of the exercise
        //In chronological order :
        //  INITIAL
        //  CONSTRUCTION_LEFT
        //  LEFT_COMPLETED
        //  CONSTRUCTION_RIGHT
        //  RIGHT_COMPLETED
        states: [
            State {
                name: "INITIAL"
                PropertyChanges {
                    target: maintitle.child; text: Str.maintitle_initial
                }
                PropertyChanges {
                    target: chright; visible:false
                }
                PropertyChanges {
                    target: chleft; visible:false
                }
            },
            State {
                name: "CONSTRUCTION_LEFT"
                PropertyChanges {
                    target: maintitle.child; text: {
                        (ch1.visible & ch2.visible & ch3.visible & ch4.visible & ch5.visible)?
                            "Good ! You found all the components. \nChange exercise or use reset card.":
                            Str.maintitle_construction_left
                    }
                }
                PropertyChanges {
                    target: chleft.child
                    color: "blue"
                    font.pointSize: 64
                }
            },
            State {
                name: "LEFT_COMPLETED"
                PropertyChanges {
                    target: maintitle.child; text: Str.maintitle_left_completed
                }
            },
            State {
                name: "CONSTRUCTION_RIGHT"
                PropertyChanges {
                    target: maintitle.child;
                    text: {
                        (ch6.visible & ch7.visible)?
                            "Good ! You found all the radicals. \nChange exercise or use reset card.":
                            Str.maintitle_construction_right
                    }
                }
                PropertyChanges {
                    target: chright.child
                    color: "blue"
                    font.pointSize: 64
                }
            },
            State {
                name: "RIGHT_COMPLETED"
                PropertyChanges {
                    target: maintitle.child; text: Str.maintitle_right_completed
                }
            }
        ]

        // A video feedback of the camera
        VideoOutput {
            anchors.top: parent.top
            anchors.left: parent.left
            // The feedback has to be forwarded by the detection, because
            // cameras expect to have only one output surface
            source: detection




        }

        // This item is a container for the 3D objects to be projected on
        // the video input image.
        // Inside this item, coodinates are in the world referential,
        // i.e. in mm, where 0,0,0 is the position of the camera in the real world
        Item {
            // It uses the projection matrix from Chilitags
            transform: Transform { matrix: detection.projectionMatrix }

            //This text only use is to solve the issue :
            //https://github.com/chili-epfl/qimchi/issues/9
            //The result is that this transparent text doesn't appear correctly
            Text {
                color: "transparent"
                text: "Nobody reads me"
                z:0
            }

            //This text displays a word using the character
            //built with the current selected radical/component
            Text {
                id: text_word
                visible: wordCombinationCard.visible
                transform: Transform { matrix: wordCombinationCard.transform }
                x:0; y:20; z:1
                text: ""
            }

            //This text displays the pinyin prononciation of the character
            //built with the current selected radical/component
            Text {
                id: text_pinyin
                visible: pinyinCard.visible
                transform: Transform { matrix: pinyinCard.transform }
                x:0; y:20; z:1
                text: ""
            }

        }

        //This text displays "Ready" on the current selected component
        ComponentBox {
            id: componentbox
        }

        RadicalBox {
            id : radicalbox
        }

        HintBox {
            id: hintbox
        }

        //mainTitle is the text at the top of the sheet
        MyItem {
            id: maintitle
            visible: true
            x_cm: Coordinates.maintitle_X
            y_cm: Coordinates.maintitle_Y
            child.color: "blue"
            child.font.pointSize: 32
        }

        //chleft is the left part of the main character
        MyItem {
            id: chleft
            visible: true
            x_cm: Coordinates.chleft_X
            y_cm: Coordinates.chleft_Y
            child.font.pointSize: 42
            child.text: "女"
        }


        //chright is the right part of the main character
        MyItem {
            id: chright
            visible: true
            x_cm: Coordinates.chright_X
            y_cm: Coordinates.chright_Y
            child.font.pointSize: 42
            child.text: "马"
        }

        //Ch1 is the composition of character 女 with component 子
        MyItem {
            id: ch1
            x_cm: Coordinates.ch1_X
            y_cm: Coordinates.ch1_Y
            child.text: "好"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }


        //ch2 is the composition of character 女 with component 生
        MyItem {
            id: ch2
            x_cm: Coordinates.ch2_X
            y_cm: Coordinates.ch2_Y
            child.text: "姓"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }

        //ch3 is the composition of character 女 with component 且
        MyItem {
            id: ch3
            x_cm: Coordinates.ch3_X
            y_cm: Coordinates.ch3_Y
            child.text: "姐"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }


        //ch4 is the composition of character 女 with component 也
        MyItem {
            id: ch4
            x_cm: Coordinates.ch4_X
            y_cm: Coordinates.ch4_Y
            child.text: "她"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }


        //ch5 is the composition of character 女 with component 西
        MyItem {
            id: ch5
            x_cm: Coordinates.ch5_X
            y_cm: Coordinates.ch5_Y
            child.text: "要"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }

        //ch5 is the composition of character 马 with component 口
        MyItem {
            id: ch6
            x_cm: Coordinates.ch6_X
            y_cm: Coordinates.ch6_Y
            child.text: "吗"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }

        //ch5 is the composition of character 马 with component 石
        MyItem{
            id: ch7
            x_cm: Coordinates.ch7_X
            y_cm: Coordinates.ch7_Y
            child.text: "码"
            Image {
                anchors.centerIn: parent
                source: "frame.png"
                z:-1
            }
        }


        MyItem {
            id: success
            visible:true
            x_cm: 6
            y_cm: 20
            property int count:{
                var c = 0;
                ch1.visible?c++:0
                ch2.visible?c++:0
                ch3.visible?c++:0
                ch4.visible?c++:0
                ch5.visible?c++:0
                ch6.visible?c++:0
                ch7.visible?c++:0
                return c
            }
            child.text: "success : " + count
            child.font.pointSize: 32
            child.color: "green"
        }

        MyItem {
            id: mistakes
            visible:true
            x_cm:14
            y_cm:20
            property int count:0
            child.text: "mistakes : " + count
            child.font.pointSize: 32
            child.color: "red"
        }

        MyItem {
            visible:true
            x_cm:22
            y_cm:20
            property int rate : 100 * (success.count+2) / (2+success.count+mistakes.count)
            child.text: "rate : " + rate + "%"
            child.font.pointSize: 32
            child.color: {
                return rate<30?"red":rate<60?"orange":rate<80?"yellow":"green"
            }
        }


    }



}
