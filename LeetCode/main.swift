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
class Solution {
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
}


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
    if s == "" {
        return 0
    }
    if s.count == 0 || s.count == 1 {
        return s.count
    }
    let ss = NSString(string: s)
    var barrier = 0
    var maxLen = 1
    for (n, _) in s.enumerated() {
        var j = n - 1
        while j >= barrier {
            if ss.substring(with: NSRange(location: n, length: 1)) == ss.substring(with: NSRange(location: j, length: 1)) {
                barrier = j + 1
                break
            }
            j = j - 1
        }
        maxLen = maxLen > n - barrier + 1 ? maxLen : n - barrier + 1
    }
    return maxLen
}

//4. 两个排序数组的中位数
//给定两个大小为 m 和 n 的有序数组 nums1 和 nums2 。
//
//    请找出这两个有序数组的中位数。要求算法的时间复杂度为 O(log (m+n)) 。
//
//示例 1:
//
//nums1 = [1, 3]
//nums2 = [2]
//
//中位数是 2.0
//示例 2:
//
//nums1 = [1, 2]
//nums2 = [3, 4]
//
//中位数是 (2 + 3)/2 = 2.5

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var num3 = nums1 + nums2
    num3 = num3.sorted(by: { (s1, s2) -> Bool in
        return s1 < s2
    })
    if num3.count <= 1 {
        return Double(num3.first!)
    }
    if num3.count % 2 == 1{
        return Double(num3[(num3.count / 2)])
    }
    let location = num3.count / 2
    return Double((num3[location] + num3[location - 1])) / Double(2)
}


//5.判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
//示例 1:

//输入: 121
//输出: true

    func isPalindrome(_ x: Int) -> Bool {
        let  a: String = String(x)
        for n in 0 ..< (a.count / 2 + a.count % 2) {
            let startIndex = a.index(a.startIndex, offsetBy: n)
            let endIndex   = a.index(a.startIndex, offsetBy: n + 1)
            let aa = a[startIndex ..< endIndex];
            
            let startIndex1 = a.index(a.startIndex, offsetBy: a.count - n - 1)
            let endIndex1   = a.index(a.startIndex, offsetBy: a.count - n)
            let aa1 = a[startIndex1 ..< endIndex1];
            if (aa != aa1) {
                return false
            }
        }
        return true;
    }

//234. 回文链表
//
//请判断一个链表是否为回文链表。
//
//
//示例 1:
//
//输入: 1->2
//输出: false
//
//
//示例 2:
//
//输入: 1->2->2->1
//输出: true
//
//进阶：
//你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？

func isPalindrome(_ head: ListNode?) -> Bool {
//    遍历链表,用数组存储
    var cacheHead = head
    var a : Array<Int> = []
    //如果只有一个节点
    if cacheHead?.next == nil {
        return true
    }
    a.append((cacheHead?.val)!)
    while ((cacheHead?.next) != nil) {
        a.append((cacheHead?.next?.val)!)
        cacheHead = cacheHead?.next
    }
    for n in 0 ..< a.count {
        let same = a[n] == a[a.count - n - 1]
        if (!same) {
            return false
        }
    }
    return true
}

//var a = ListNode(1)
//var b = ListNode(2)
//var c = ListNode(1)
//var d = ListNode(4)
//
//a.next = b
//b.next = c
//c.next = d
//
//print(isPalindrome(a) ? "yes" : "no")



//判断一个 9x9 的数独是否有效。只需要根据以下规则，验证已经填入的数字是否有效即可。
//
//数字 1-9 在每一行只能出现一次。
//数字 1-9 在每一列只能出现一次。
//数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
//
//
//上图是一个部分填充的有效的数独。
//
//数独部分空格内已填入了数字，空白格用 '.' 表示。
//
//示例 1:
//
//输入:
//[
//["5","3",".",".","7",".",".",".","."],
//["6",".",".","1","9","5",".",".","."],
//[".","9","8",".",".",".",".","6","."],
//["8",".",".",".","6",".",".",".","3"],
//["4",".",".","8",".","3",".",".","1"],
//["7",".",".",".","2",".",".",".","6"],
//[".","6",".",".",".",".","2","8","."],
//[".",".",".","4","1","9",".",".","5"],
//[".",".",".",".","8",".",".","7","9"]
//]
//输出: true
//示例 2:
//
//输入:
//[
//["8","3",".",".","7",".",".",".","."],
//["6",".",".","1","9","5",".",".","."],
//[".","9","8",".",".",".",".","6","."],
//["8",".",".",".","6",".",".",".","3"],
//["4",".",".","8",".","3",".",".","1"],
//["7",".",".",".","2",".",".",".","6"],
//[".","6",".",".",".",".","2","8","."],
//[".",".",".","4","1","9",".",".","5"],
//[".",".",".",".","8",".",".","7","9"]
//]
//输出: false
//解释: 除了第一行的第一个数字从 5 改为 8 以外，空格内其他数字均与 示例1 相同。
//但由于位于左上角的 3x3 宫内有两个 8 存在, 因此这个数独是无效的。
//说明:
//
//一个有效的数独（部分已被填充）不一定是可解的。
//只需要根据以上规则，验证已经填入的数字是否有效即可。
//给定数独序列只包含数字 1-9 和字符 '.' 。
//给定数独永远是 9x9 形式的。

func isValidSudoku(_ board: [[Character]]) -> Bool {
    
    //判断一个数组
    func isValidArray(_ arr: [Character]) -> Bool {
        //用一个字典存储.key : 0 ... 9,判断唯一性
        var a = Dictionary<Character, Any>()
        for n in arr {
            if n != "." {
                if a[n] == nil {
                    a[n] = "1"
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    //验证行
    for n in board {
        let valid = isValidArray(n)
        if (!valid) {
            return false
        }
    }
    
    //验证列
    let aa:Character = "ss".first!
    
    var row: Array<Character> = [aa, aa, aa, aa, aa, aa, aa, aa, aa]
    for n in 0 ..< 9 {
        for (index, item) in board.enumerated() {
            let cc = item[n]
            row[index] = cc
            if (index == 8) {
                let valid = isValidArray(row)
                if (!valid) {
                    return false
                }
            }
        }
    }

    //验证9宫格
    //遍历三次每次取出三个数组
    for n in 0 ..< 3 {
        let aa = board[0 + n * 3]
        let bb = board[1 + n * 3]
        let cc = board[2 + n * 3]
        for nn in 0 ..< 3 {
            row[0] = aa[0 + nn * 3]
            row[1] = aa[1 + nn * 3]
            row[2] = aa[2 + nn * 3]
            row[3] = bb[0 + nn * 3]
            row[4] = bb[1 + nn * 3]
            row[5] = bb[2 + nn * 3]
            row[6] = cc[0 + nn * 3]
            row[7] = cc[1 + nn * 3]
            row[8] = cc[2 + nn * 3]
            let valid = isValidArray(row)
            if (!valid) {
                return false
            }
        }
    }
    return true
}

var a = [
    ["8","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]

var b = [[".".first!,".".first!,"4".first!,".".first!,".".first!,".".first!,"6".first!,"3".first!,".".first!],
         [".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!],
         ["5".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,"9".first!,".".first!],
         [".".first!,".".first!,".".first!,"5".first!,"6".first!,".".first!,".".first!,".".first!,".".first!],
         ["4".first!,".".first!,"3".first!,".".first!,".".first!,".".first!,".".first!,".".first!,"1".first!],
         [".".first!,".".first!,".".first!,"7".first!,".".first!,".".first!,".".first!,".".first!,".".first!],
         [".".first!,".".first!,".".first!,"5".first!,".".first!,".".first!,".".first!,".".first!,".".first!],
         [".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!],
         [".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!,".".first!]
] as [[Character]]

//var testa = isValidSudoku(b)
//if testa {
//    print("yes")
//} else {
//    print("no")
//}

//37. 解数独
//
//编写一个程序，通过已填充的空格来解决数独问题。
//
//一个数独的解法需遵循如下规则：
//
//数字 1-9 在每一行只能出现一次。
//数字 1-9 在每一列只能出现一次。
//数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
//空白格用 '.' 表示。
//
//
//
//一个数独。
//
//
//
//答案被标成红色。

//20. 有效的括号
//
//给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
//
//有效字符串需满足：
//
//左括号必须用相同类型的右括号闭合。
//左括号必须以正确的顺序闭合。
//注意空字符串可被认为是有效字符串。
//
//示例 1:
//
//输入: "()"
//输出: true
//示例 2:
//
//输入: "()[]{}"
//输出: true
//示例 3:
//
//输入: "(]"
//输出: false
//示例 4:
//
//输入: "([)]"
//输出: false
//示例 5:
//
//输入: "{[]}"
//输出: true


//这个方法是判断条件是 合格的,但是合格的要求比较多,容易复杂
//所以用不合格的来筛选,会方便很多
//func isValid(_ s: String) -> Bool {
//
//    //检查 是否含有 () [] {}
//    //如果有的话, 删除() [] {}
//    //重复上述步骤,直到length为0,如果不为0,返回faluse
//    //如果没有,返回faluse
//    var ss = s
//
//    if (ss.count % 2) == 1 {return false}
//
//    func canDeleteS(sss : String) -> (Bool, String) {
//        var a = sss
//        if a.contains("()") {
//            let range = a.range(of: "()")
//            a.removeSubrange(range!)
//            return (true, a)
//        }
//        if a.contains("[]") {
//            let range = a.range(of: "[]")
//            a.removeSubrange(range!)
//            return (true, a)
//        }
//        if a.contains("{}") {
//            let range = a.range(of: "{}")
//            a.removeSubrange(range!)
//            return (true, a)
//        }
//        return (false, a)
//    }
//
//    while ss.count != 0 {
//        let cc = canDeleteS(sss: ss)
//        if (cc.0) {
//            ss = cc.1
//        } else {
//            return false
//        }
//    }
//    return ss.count > 0 ? false : true
//
//}

func isValid(_ s: String) -> Bool {
    return true
}

let aa = "([)]"
let bb = "[({})]"

if(isValid(bb)) {
    print("yes")
} else {
    print("no")
}




































