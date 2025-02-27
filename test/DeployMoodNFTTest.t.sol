// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";
import {MoodNFT} from "src/MoodNFT.sol";

contract DeployMoodNFTTest is Test {
    DeployMoodNFT public deployMoodNFT;
    string private expectedSvgImageURI = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGNpcmNsZSBjeD0iMTAwIiBjeT0iMTAwIiBmaWxsPSJ5ZWxsb3ciIHI9Ijc4IiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjMiLz48ZyBjbGFzcz0iZXllcyI+PGNpcmNsZSBjeD0iNzAiIGN5PSI4MiIgcj0iMTIiLz48Y2lyY2xlIGN4PSIxMjciIGN5PSI4MiIgcj0iMTIiLz48L2c+PHBhdGggZD0ibTEzNi44MSAxMTYuNTNjLjY5IDI2LjE3LTY0LjExIDQyLTgxLjUyLS43MyIgc3R5bGU9ImZpbGw6bm9uZTsgc3Ryb2tlOiBibGFjazsgc3Ryb2tlLXdpZHRoOiAzOyIvPjwvc3ZnPg==";
    string public svgURI;
    string private svg = '<svg viewBox="0 0 200 200" width="400" height="400" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" fill="yellow" r="78" stroke="black" stroke-width="3"/><g class="eyes"><circle cx="70" cy="82" r="12"/><circle cx="127" cy="82" r="12"/></g><path d="m136.81 116.53c.69 26.17-64.11 42-81.52-.73" style="fill:none; stroke: black; stroke-width: 3;"/></svg>';

    function setUp() public {
        deployMoodNFT = new DeployMoodNFT();
    }

    function testConvertSVGImageToURI() public {
        svgURI = deployMoodNFT.svgToImageURI(svg);
        console.log(svg);
        assert(keccak256(abi.encodePacked(expectedSvgImageURI)) == keccak256(abi.encodePacked(svgURI)));
    }
}