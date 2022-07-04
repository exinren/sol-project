// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 注意
// 此版本的 SafeMath 只能与 Solidity 0.8 或更高版本一起使用，
// 因为它依赖于编译器的内置溢出检查。

/**
 * @dev 封装了 Solidity 的算术运算。
 *
 * 注意：从 Solidity 0.8 开始，通常不需要 `SafeMath`，因为编译器
 * 现在已内置溢出检查。
 */
library SafeMath {
    /**
     * @dev 返回两个无符号整数的加法，带有溢出标志。
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev 返回两个无符号整数的减法，带有溢出标志。
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev 返回两个无符号整数的乘积，带有溢出标志。
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas 优化: 这比要求 'a' 不为零要便宜，但是
             // 如果 'b' 也被测试，那么好处就消失了。
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev 返回两个无符号整数的除法，除以零标志。
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev 返回除以零标志的两个无符号整数的余数。
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev 返回两个无符号整数的加法，返回溢出
     *
     * 与 Solidity 的 `+` 运算符对应。
     *
     * 要求:
     *
     * - 加法不能溢出。
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev 返回两个无符号整数的减法，恢复溢出（当结果为负时）。
     *
     * 与 Solidity 的 `-` 运算符对应。
     *
     * 要求:
     *
     * - 减法不能溢出。
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev 返回两个无符号整数的乘积，返回溢出。
     *
     * 与 Solidity 的 `*` 运算符对应。
     *
     * 要求:
     *
     * - 乘法不能溢出。
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev 返回两个无符号整数的整数除法，恢复被零除。 结果向零舍入。
     *
     * 与 Solidity 的 `/` 运算符对应。
     *
     * 要求:
     *
     * - 除数不能为零。
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev 返回两个无符号整数相除的余数。 （无符号整数模），除以零时恢复。
     *
     * 与 Solidity 的 `%` 运算符对应。 此函数使用“revert”操作码（保留剩余的 gas 不变），而 Solidity 使用无效的操作码进行还原（消耗所有剩余的 gas）。
     *
     * 要求:
     *
     * - 除数不能为零。
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev 返回两个无符号整数的减法，在溢出时返回自定义消息（当结果为负时）。
     *
     * 注意：此函数已被弃用，因为它需要为不必要的错误消息分配内存。 出于自定义还原原因，请使用 {trySub}。
     *
     * 与 Solidity 的 `-` 运算符对应。
     *
     * 要求:
     *
     * - 减法不能溢出。
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev 返回两个无符号整数的整数除法，在除以零时返回自定义消息。 结果向零舍入。
     *
     * 与 Solidity 的 `/` 运算符对应。 注意：这个函数使用一个 `revert` 操作码（保留剩余的 gas 不变），而 Solidity 使用一个无效的操作码来还原（消耗所有剩余的 gas）。
     *
     * 要求:
     *
     * - 除数不能为零。
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev 返回两个无符号整数相除的余数。 （无符号整数模），除以零时返回自定义消息。
     *
     * 注意：此函数已被弃用，因为它需要为不必要的错误消息分配内存。 出于自定义还原原因，请使用 {tryMod}。
     *
     * 与 Solidity 的 `%` 运算符对应。 此函数使用“revert”操作码（保留剩余的 gas 不变），而 Solidity 使用无效的操作码进行还原（消耗所有剩余的 gas）。
     *
     * 要求:
     *
     * - 除数不能为零。
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}