// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract CharitableCauses{
    // Tipado de datos
    struct Cause{
        uint Id;
        string name;
        uint objective;
        uint amount_collected;
    }

    // Cantidad de causes benéficas
    uint causes_count = 0;

    // Mapping
    // donde la clave es un str y el valor es tipo Cause
    mapping (string => Cause) causes;


    // Función para crear causa
    // Se crea con su nombre y su dinero objetivo
    function addCause(string memory _name, uint _objective) public payable{
        causes_count++;
        Cause memory newCause = Cause(causes_count, _name, _objective, 0);
        causes[_name] = newCause;
    }

    // Ver si llegamos al dinero objetivo
    function moneyIsDonable(string memory _name, uint _money) private view returns(bool){
        Cause storage sellectedCause = causes[_name];
        if(sellectedCause.objective >= (sellectedCause.amount_collected + _money)){
            return true;
        }
        return false;
    }

    // Función para donar a ua causa
    function donateMoney(string memory _name, uint _amount) public returns(bool){
        
        if (moneyIsDonable(_name, _amount)){
            causes[_name].amount_collected = causes[_name].amount_collected + _amount;
            return true;
        }
        return false;
    }

    // Función para saber si llegamos al dinero objetivo
    function moneyIsColleted(string memory _name) public view returns(bool,uint){
        Cause memory sellectedCause = causes[_name];

        if(sellectedCause.objective >= sellectedCause.amount_collected){
            return (false, sellectedCause.amount_collected);
        }

        return (true, sellectedCause.amount_collected);
    }
}