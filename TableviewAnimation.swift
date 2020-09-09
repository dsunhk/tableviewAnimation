//
//  Animation.swift
//  LearnJPL
//
//  Created by dsun on 4/9/2020.
//  Copyright © 2020 dsun. All rights reserved.
//

import Foundation
import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator {
    // properties
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        //
        guard !hasAnimatedAllCells else { return }
        //
        animation(cell, indexPath, tableView)
        hasAnimatedAllCells = (tableView.visibleCells.lastIndex(of: cell) != nil)
    }
}

enum AnimationFactory {

    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, _ in
            // property
            cell.alpha = 0
            // uiviewanimation
            UIView.animate(withDuration: duration,delay: delayFactor * Double(indexPath.row),animations: {
                    cell.alpha = 1
            })}
    }
//    let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.05)
//    let animator = Animator(animation: animation)
//    animator.animate(cell: cell, at: indexPath, in: tableView)
    
    //
    static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            // property
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
            // uiviewanimation
            UIView.animate(withDuration: duration,delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.4,initialSpringVelocity: 0.1,options: [.curveEaseInOut],
                animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })}
    }
    
    //
//    let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration:   1.0, delayFactor: 0.05)
//    let animator = Animator(animation: animation)
//    animator.animate(cell: cell, at: indexPath, in: tableView)
    
    static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, _ in
            //
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight / 2)
            cell.alpha = 0
            //
            UIView.animate(withDuration: duration,delay: delayFactor * Double(indexPath.row),options: [.curveEaseInOut],animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })}
    }
    //
//    let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration:     0.5, delayFactor: 0.05)
//    let animator = Animator(animation: animation)
//    animator.animate(cell: cell, at: indexPath, in: tableView)
    //
    static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            //
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)

            UIView.animate(withDuration: duration,delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    //
//    let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
//    let animator = Animator(animation: animation)
//    animator.animate(cell: cell, at: indexPath, in: tableView)
    //
    
    
    
}
