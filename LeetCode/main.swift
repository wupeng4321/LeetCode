//
//  main.swift
//  LeetCode
//
//  Created by wupeng on 2018/5/7.
//  Copyright © 2018年 wupeng. All rights reserved.
//

import Foundation
/*1. 两数之和
*给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。

*你可以假设每个输入只对应一种答案，且同样的元素不能被重复利用。

*示例:

*给定 nums = [2, 7, 11, 15], target = 9

*因为 nums[0] + nums[1] = 2 + 7 = 9
*所以返回 [0, 1]
*/
//class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for (n, c) in nums.enumerated() {
            let odd = target - c
            for i in n + 1 ..< nums.count {
                if nums[i] == odd {
                    return [n , i]
                }
            }
        }
        return []
    }
//}





/* 2.两数相加
 *给定两个非空链表来表示两个非负整数。位数按照逆序方式存储，它们的每个节点只存储单个数字。将两数相加返回一个新的链表。
 *
 *你可以假设除了数字 0 之外，这两个数字都不会以零开头。
 *
 *示例：
 *
 *输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
 *输出：7 -> 0 -> 8
 *原因：342 + 465 = 807
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

//class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var ll1 = l1
        var ll2 = l2
        var p = ListNode(0)
        let pp = p
        var carry = 0
        while (ll1 != nil) || (ll2 != nil) || carry > 0 {
            var v1 = 0
            if ll1 != nil {
                v1 = (ll1?.val)!
            }
            var v2 = 0
            if ll2 != nil {
                v2 = (ll2?.val)!
            }
            let sum = v1 + v2 + carry
            carry = sum / 10
            p.next = ListNode(sum % 10)
            p = p.next!
            ll1 = ll1?.next
            ll2 = ll2?.next
        }
        return pp.next
    }
//}


/*3. 无重复字符的最长子串

*给定一个字符串，找出不含有重复字符的最长子串的长度。

*示例：

*给定 "abcabcbb" ，没有重复字符的最长子串是 "abc" ，那么长度就是3。

*给定 "bbbbb" ，最长的子串就是 "b" ，长度是1。

*给定 "pwwkew" ，最长子串是 "wke" ，长度是3。请注意答案必须是一个子串，"pwke" 是 子序列  而不是子串。
*/
func lengthOfLongestSubstring(_ s: String) -> Int {
    if s.count == 0 || s.count == 1 {return s.count}
    var a = String(s.first!)
    var count = 0
    var ss = s
    for _ in ss {
        ss.removeFirst()
        for cc in ss {
            if a.contains(cc) {
//                if a.count > count {count = a.count}
                break
            } else {
                a = a + "\(cc)"
            }
            if a.count > count {count = a.count}
        }
        if count >= ss.count {break}
        a = String(ss.first!)
    }
    return count
}

let a = lengthOfLongestSubstring("abcabcbb")
print(a)


































