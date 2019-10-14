#!/bin/bash 
#INFOSERVPUBLIQUE 10.202.0.109
#COMMUNITY IUTR0CommunityPub
#V2
#— OID SNMP pourcentage CPU Idle : 1.3.6.1.4.1.2021.11.11.0 
#— OID SNMP espace memoire total : 1.3.6.1.4.1.2021.4.5.0 
#— OID SNMP espace memoire libre : 1.3.6.1.4.1.2021.4.6.0

requete(){
    if [ "$verif" -eq "1" ]
    then 
        CPUAct=snmpwalk -v 2c -c $COM $IP 1.3.6.1.4.1.2021.11.11.0 |cut -d: -f4
    fi
    if [ "$verif" -eq "2" ]
    then 
        
        RAMTotal=snmpwalk -v 2c -c $COM $IP 1.3.6.1.4.1.2021.4.5.0|cut -d: -f4|cut -d" "  -f2
        RAMAct=snmpwalk -v 2c -c $COM $IP 1.3.6.1.4.1.2021.4.6.0|cut -d: -f4 |cut -d" " -f2

    fi
    if [ "$verif" -eq "3" ]
    then 
        CPUAct=snmpwalk -v 2c -c $COM $IP 1.3.6.1.4.1.2021.11.11.0|cut -d: -f4 
        RAMTotal=snmpwalk -v 2c -c $COM $IP 1.3.6.1.4.1.2021.4.5.0|cut -d: -f4 | cut -d" " -f2
        RAMAct=snmpwalk -v 2c -c $COM $IP 1.3.6.1.4.1.202.4.6.0|cut -d: -f4 | cut -d" " -f2

    fi

}

verif(){
    if [ "$warning" -ne 0 ]
    then 
        if [ "$verif" -eq "1" ]
        then 
            if [ "$CPUAct" -gt $warning ]
            then 
                if [ $TG -eq 0 ]
                then
                    echo "ATTENTION utilisation CPU au dessus du seuil warning"
                fi 
            fi
            if [ "$CPUAct" -gt $critique ]
            then 
                if [ $TG -eq 0 ]
                then
                    echo "CPU ON THE HELLLL !!!!!!!!"
                fi 
            fi
             
            
            
        fi
    fi
    if [ "$verif" -eq "2" ]
    then 
        RAMLeft= echo $(($RAMTotal-$RAMAct))
        if [ "$TG" -eq "0" ]
        then 
            if [ "$RAMLeft" -lt "$warning" ]
            then
                echo "Attention utilisation RAM trop haute"
            fi
            if [ "$RAMLeft" -lt "$critique" ]
            then
                echo "RAM ON THE HELL"
            fi 
        fi
       

    fi
    if [ "$verif" -eq "3" ]
    then 
        echo "CPU = $CPUAct; warning Value: $warning; critique value= $critique"
        echo "RAM MAX = $RAMTotal; warning Value: $warning; critique value= $critique"
        echo "RAM USE  = $RAMAct; warning Value: $warning; critique value= $critique"

         
    fi

    


}

warning=0

    while getopts ":p:i:c:v:w:W:P:h:" option
    do
        case "${option}" in 
            p)
                #-p Defini le point de contrôle à aller verifier
                #   1 pour verifier Taux Utilisation CPU
                #   2 pour verifier Taux Utilisation RAM 
                #   3 pour verifier les deux
                if [ "$OPTARG" -eq "1" ]
                then
                    verif=1
                fi
                if [ "$OPTARG" -eq "2" ]
                then
                    verif=2
                fi
                if [ "$OPTARG" -eq "3" ]
                then
                    verif=3
                fi
                
                    
                ;;
            i)  
                #-i IP cible
                IP=$OPTARG 
                echo test
                ;;

            c)
                #-c Communauté SNMP
                COM=$OPTARG:q


                ;;

            v)
                #-v Version de la communauté SNMP
                version=$OPTARG


                ;;
            w)  
                #-w Définition Premier seuil dalerte Warning

                warning=$OPTARG

                ;;
            W)
                #-W Définition Seuil Critique
                critique=$OPTARG
                ;;

            P)
                #-P Affiche les perfomances si egale 0
                TG=$OPTARG
                ;;

            h)
                #-h Help 
                cat script.sh |grep "#"
                 
                ;;
    
            esac 
    done



