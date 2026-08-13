do_install:append() {
    bbwarn "Appending to do_install for tegra-storage-layout-base"
    bbwarn "XML path=${D}${datadir}/tegraflash/external-flash.xml"

    INSTALLED="${D}${datadir}/tegraflash/external-flash.xml"
    if [ -f "${INSTALLED}" ]; then
        bbwarn "Modifying external-flash.xml to remove DATAFILE from permanet_user_storage and add it to UDA partition"
        sed -i '/<partition name="permanet_user_storage"/,/<\/partition>/{
            /<filename>[[:space:]]*DATAFILE[[:space:]]*<\/filename>/d
        }' "${INSTALLED}"

        sed -i '/<partition name="UDA"/,/<\/partition>/{
            s|<\/partition>|    <filename> DATAFILE </filename>\n        </partition>|
        }' "${INSTALLED}"
    else
        bbwarn "Partition layout external XML file not found: ${INSTALLED}"
    fi
}