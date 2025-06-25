// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NoteStorage {
    string[] private notes;

    event NoteAdded(string note);

    function storeNote(string memory _note) public {
        notes.push(_note);
        emit NoteAdded(_note);
    }

    function getNotes() public view returns (string[] memory) {
        return notes;
    }
}
