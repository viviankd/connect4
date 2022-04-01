//
//  gridView.swift
//  numberGrid
//
//  Created by Vivian Duong on 3/2/22.
//

import UIKit

@IBDesignable

class gridView: UIView {
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var announcement: UILabel!
    
    
    var height: CGFloat = 0
    
    
    var width: CGFloat = 0
    var shortSide: CGFloat = 0
    var longSide: CGFloat = 0
    var verticalOffSet: CGFloat = 0
    var horizontalOffSet: CGFloat = 0
    var turn = 0 // player 1 turn = 0 p2 turn = 1 
    var p1Score = 0
    var p2Score = 0
    var winner = 0
//    make a 6x7 grid
    var touchCount = [[0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0]]
    
    
    @IBAction func newGame(_ sender: Any) {
        touchCount = [[0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0]]
        winner = 0
        announcement.text = "Player " + String(turn + 1) + "'s turn"
        turn = 0
        setNeedsDisplay()
        
    }
    
    @IBAction func reset(_ sender: Any) {
        touchCount = [[0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0],
                              [0, 0, 0, 0, 0, 0, 0]]
        winner = 0
        announcement.text = "Player " + String(turn + 1) + "'s turn"
        p1Score = 0
        p2Score = 0
        turn = 0
        setNeedsDisplay()
        
    }
    override func draw(_ rect: CGRect) {
        if touchCount == [[0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0, 0, 0]] {
            announcement.text = "Player " + String(turn + 1) + "'s turn"
        }
        height = bounds.height
        width = bounds.width
        shortSide = min(width, height)
        longSide = max(width, height)
        player1Score.text = String(p1Score)
        player2Score.text = String(p2Score)
        if height > width {
            verticalOffSet = (longSide - shortSide) / 2
        }
        if height < width {
            horizontalOffSet = (longSide - shortSide) / 2
        }
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: (shortSide / (7))),
            .foregroundColor: UIColor.black
            ]
        let text = "0"
        
        let zeroSize = text.size(withAttributes: attributes)
        let halfZeroWidth = CGFloat(zeroSize.width / 2);
        let halfZeroHeight = CGFloat(zeroSize.height / 2);
        let boxWidth = shortSide/CGFloat(7);
        let boxHeight = shortSide/CGFloat(7);
        let countColors = [UIColor.purple, UIColor.systemPink]
    
        let plus = UIBezierPath()
        plus.lineWidth = 1.5
        UIColor.black.setStroke()
        
        // Draw in the grid lines
        for x in 0...7  {
            for y in 1...7 { // horizontal lines
                    plus.move(to: CGPoint(x: horizontalOffSet, y: ((shortSide / CGFloat(7)) * CGFloat(y))))
                    plus.addLine(to: CGPoint(x: shortSide + horizontalOffSet, y:((shortSide / CGFloat(7)) * CGFloat(y)) + verticalOffSet))
                    plus.stroke()
                    
                // draw vertical lines
                    plus.move(to: CGPoint(x: ((shortSide / CGFloat(7)) * CGFloat(x)) + horizontalOffSet, y: verticalOffSet + boxHeight))
                    plus.addLine(to: CGPoint(x: ((shortSide / CGFloat(7)) * CGFloat(x)) + horizontalOffSet, y: shortSide + verticalOffSet))
                    plus.stroke()

            }
        }
        // updated and would work with a rectangle view
        // drawing 0's
        var row = 0
        var col = 0
        for x in stride(from: (horizontalOffSet) , to: shortSide + horizontalOffSet, by: boxWidth) {
            for y in stride(from: (verticalOffSet) + boxHeight, to: shortSide + verticalOffSet, by: boxWidth)  {
                if(touchCount[row][col] != 0){
                    countColors[touchCount[row][col]-1].set()
                    UIBezierPath(ovalIn: CGRect(x: CGFloat(x), y: CGFloat(y), width: boxWidth, height: boxHeight)).fill()
                }
//                String(touchCount[row][col]).draw(at: CGPoint(x: ((x + (boxWidth / 2) - halfZeroWidth)), y: (y + (boxHeight / 2) - halfZeroHeight)), withAttributes: attributes)
                row += 1
            }
            col += 1
            row = 0
        }
 
    }
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
//        let attributes: [NSAttributedString.Key : Any] = [
//            .font: UIFont.systemFont(ofSize: 12),
//            .foregroundColor: UIColor.black
//            ]
        let tapPoint = sender.location(in: self)
        
//      get the row and column of the tapped box
        // need to adjust for padding
        let row = Int(abs(floor((tapPoint.y - verticalOffSet) / (shortSide / 7)) - 1))
        let col = Int(abs(floor((tapPoint.x - horizontalOffSet) / (shortSide / 7))))
       
        // index out of bounds
        if row < 0 || row > 5 {
            return
        }
        if col < 0 || col > 6{
            return
        }
        // if the box has already been touched, return and let player pick again
        if(touchCount[row][col] != 0){
            return
        }
        
        if row != 5 {
            if touchCount[row + 1][col] == 0 {
                return
            }
        }
        // don't let them play until they click new game
        if winner != 0 {
            return
        }
        touchCount[row][col] = (turn + 1)
        if checkWin(row: row, col:col) == 1 {
            // display winner message
            // increment winner's score
            if turn == 0 {
                p1Score = p1Score + 1
            } else if turn == 1 {
                p2Score = p2Score + 1
            }
            winner = turn + 1
        }
        if winner != 0 {
            declareWinner()
        }
        turn = (turn + 1) % 2
        
       // print(touchCount)
        //print(tapPoint.x)
        //print(horizontalOffSet)
        print("col", col)
        print("row", row)
        setNeedsDisplay()
    }
    
    func checkWin(row: Int, col: Int) -> Int {
        var horCounter = 0
        var vertCounter = 0
        for x in 0...6 {
            // check ohrizontal wins
            if touchCount[row][x] == (turn + 1) {
                horCounter = (horCounter + 1)
            } else {
                horCounter = 0
//                print(touchCount[row])
            }
            if horCounter >= 4 {
                return 1
            }
        }
        // check veritcal wins
        for y in 0...5 {
            if touchCount[y][col] == (turn + 1) {
                vertCounter = (vertCounter + 1)
            } else {
                vertCounter = 0
            }
            if vertCounter >= 4 {
                return 1
            }
        }
        return 0
    }
    func declareWinner() {
        announcement.text = "Player " + String(turn + 1) + " wins!"
    }
}
