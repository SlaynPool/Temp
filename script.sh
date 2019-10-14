#!/bin/bash 
#INFOSERVPUBLIQUE 10.202.0.109
#COMMUNITY IUTR0CommunityPub
#V2
#— OID SNMP pourcentage CPU Idle : 1.3.6.1.4.1.2021.11.11.0 
#— OID SNMP espace memoire total : 1.3.6.1.4.1.2021.4.5.0 
#— OID SNMP espace memoire libre : 1.3.6.1.4.1.2021.4.6.0

fct_arg(){
    while getopts "picvwW:P:" option
    do
        case $option in 
            p)
                #-p Defini le point de contrôle à aller verifier
                #   1 pour verifier Taux Utilisation CPU
                #   2 pour verifier Taux Utilisation RAM 
                #   3 pour verifier les deux
                if [ "$OPTARG" -eq "1" ]
                then
                    
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
                #-w Définition Premier seuil d'alerte Warning

                warning=$OPTARG

                ;;
            W)
                #-W Définition Seuil Critique
                critique=$OPTARG
                ;;

            P)
                #-P Affiche les perfomances si egale 1
                perf=$OPTARG
                ;;

            h)
                #-h Help 
                cat $0 |grep #
                ;;
    
            esac 
    done


}
