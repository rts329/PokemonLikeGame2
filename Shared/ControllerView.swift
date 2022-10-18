//
//  DPadView.swift
//  PokemonLikeGame
//
//  Created by Ryan Shaw on 9/28/22.
//

import SwiftUI

struct ControllerView: View {
    var body: some View {
        HStack {
            Spacer()
            DPadView()
            Spacer()
            ABButton(buttonText: "A", buttonAction: aButtonAction())
            Spacer()
            ABButton(buttonText: "B", buttonAction: bButtonAction())
            Spacer()
        }
    }
}

struct DPadView: View {
    var body: some View {
        VStack {
            DPadButton(buttonText: "^", buttonAction: dpadUpAction())
            HStack{
                DPadButton(buttonText: "<", buttonAction: dpadLeftAction())
                Text("").frame(width: 40, height: 40)
                DPadButton(buttonText: ">", buttonAction: dpadRightAction())
            }
            DPadButton(buttonText: "v", buttonAction: dpadDownAction())
        }
    }
}

struct DPadButton: View {
    var buttonText:String = "Button Text"
    var buttonAction: ()
    var body: some View {
        Button {
            self.buttonAction
        } label: {
            Text(buttonText)
                .frame(width: 40, height: 40)
                .background(Color.black)
                .font(.system(size:16, weight: .bold))
                .cornerRadius(10)
                .foregroundColor(.white)
        }
    }
}

func dpadUpAction() {
    print("Hello world")
}

func dpadLeftAction() {
    print("Hello world")
}

func dpadRightAction() {
    print("Hello world")
}

func dpadDownAction() {
    print("Hello world")
}


struct ABButton: View {
    var buttonText:String = "A"
    var buttonAction: ()
    var body: some View {
        Button {
            self.buttonAction
        } label: {
            Text(buttonText).frame(width: 60, height: 60).background(Color.black)
                .font(.system(size:16, weight: .bold))
                .cornerRadius(100)
                .foregroundColor(.white)
                .padding(10)
        }
    }
}

func aButtonAction() {
    print("Hello world")
}
func bButtonAction() {
    print("Hello world")
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}
