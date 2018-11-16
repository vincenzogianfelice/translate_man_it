#!/bin/bash

NAME_DIR="translate_man_it"
PERC="/usr/share/man/$NAME_DIR"
MANDATORY_MANPATH="MANDATORY_MANPATH	$PERC"
MANDB_MAP="MANDB_MAP	$PERC   $PERC/cache"

if [ "`whoami`" != "root" ]; then

   echo -e "\nLanciare lo script da utente root"
   exit 1

fi

case "$1" in

install)

   cat /etc/manpath.config | grep -i "$MANDATORY_MANPATH" > /dev/null

   if [ "$?" != "0" ]; then

      echo "$MANDATORY_MANPATH" >> /etc/manpath.config

   fi

   cat /etc/manpath.config | grep -i "$MANDB_MAP" > /dev/null

   if [ "$?" != "0" ]; then

      echo "$MANDB_MAP" >> /etc/manpath.config

   fi

   if [ ! -d $PERC ]; then

      mkdir -p $PERC/it
   fi

   if [ ! -d /var/cache/man/$NAME_DIR ]; then

      mkdir /var/cache/man/$NAME_DIR

   fi

   cp -R man* $PERC/it

   echo -e "\nDigitare 'sudo mandb' per aggiornare la cache"

   ;;

uninstall)

   rm -rf $PERC /var/cache/man/$NAME_DIR

   cp /etc/manpath.config /etc/manpath.config.backup

   cat /etc/manpath.config | sed -r -s 's/.*translate_man_it.*//' > /etc/.manpath.config
   mv /etc/.manpath.config /etc/manpath.config

   echo -e "\nDigitare 'sudo mandb' per aggiornare la cache"

   ;;

esac

exit 0
