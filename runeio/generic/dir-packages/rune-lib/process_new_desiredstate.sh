#!/bin/sh

donothing () {
	echo "donothing"
}

firmware_upgrade () {
	echo "firmware_upgrade"
}

hids_signature_upgrade () {
	echo "hids_signature_upgrade"
}

av_signature_upgrade () {
	echo "av_signature_upgrade"
}

dns_whitelist_upgrade () {
	echo "dns_whitelist_upgrade"
}

change_firmware_build_epoch () {
	echo "change_firmware_build_epoch"
}

change_firmware_path () {
	firmware_upgrade
}

change_firmware_md5 () {
	donothing
}

change_devfinger_interval () {
	echo "change_devfinger_interval"
}

change_netfinger_interval () {
	echo "change_netfingter_interval"
}

change_hids_signature () {
	echo "change_hids_signature"
        donothing
}

change_hids_sig_path () {
	echo "change_hids_sig_path"
	hids_signature_upgrade
}

change_hids_sig_md5 () {
	echo "change_hids_sig_md5"
        donothing
}

change_hids_interval () {
	echo "change_hids_interval"
}

change_fw_interval () {
	echo "change_fw_interval"
}

change_proxy_interval () {
	echo "change_proxy_interval"
}

change_av_signature () {
	echo "change_av_signature"
        donothing
}

change_av_sig_path () {
	echo "change_av_sig_path"
	av_signature_upgrade
}

change_av_sig_md5 () {
	echo "change_av_sig_md5"
        donothing
}

change_av_interval () {
	echo "change_av_interval"
}

change_dns_interval () {
	echo "change_dns_interval"
}

change_dns_whitelist_path () {
	echo "change_dns_whitelist_path"
	dns_whitelist_upgrade
}

change_flow_interval () {
	echo "change_flow_interval"
}

compare_process_param_change () {
#	echo "In param: $1  $2"

	old_val=$(eval echo \$$1)
#	echo "$1 : $old_val"
	a=new_${1}
	new_val=$(eval echo \$$a)
#	echo "$a : $new_val"
	call_func=change_${1}
	msg=${2}

	if [ ${new_val} != ${old_val} ]; then
		echo "$0: Desired State param ${msg} changed to ${new_val} from ${old_val}"
		eval ${1}=${new_val}
		${call_func}
		echo "var: $1 is now set to $(eval echo \$$1)"
	fi
}


get_sys_var_param_firmware_build_epoch () {
	firmware_build_epoch=`./versionBuildDate.sh | cut -d' ' -f4`
}

get_sys_var_param_firmware_path () {
	firmware_path=doesnotmatter
}

get_sys_var_param_firmware_md5 () {
	firmware_md5=doesnotmatter
}

get_sys_var_param_devfinger_interval () {
	devfinger_interval=0
}

get_sys_var_param_netfinger_interval () {
	netfinger_interval=0
}

get_sys_var_param_hids_signature () {
	hids_signature=doesnotmatter
}

. /lib/rune/parse_desired_state.sh
parse_desiredstatedoc_params

param_1=firmware_build_epoch
param_2=firmware_path
param_3=firmware_md5
param_4=devfinger_interval
param_5=netfinger_interval
param_6=hids_signature
param_7=hids_sig_path
param_8=hids_sig_md5
param_9=hids_interval
param_10=fw_interval
param_11=proxy_interval
param_12=av_signature
param_13=av_sig_path
param_14=av_sig_md5
param_15=av_interval
param_16=dns_interval
param_17=flow_interval

param_name_1='Firmware Build epoch'
param_name_2='Firmware Build path'
param_name_3='Firmware md5'
param_name_4='DevFinger interval'
param_name_5='NetFinger interval'
param_name_6='HIDS signature'
param_name_7='HIDS signature path'
param_name_8='HIDS signature md5'
param_name_9='HIDS interval'
param_name_10='FW interval'
param_name_11='Proxy interval'
param_name_12='AV signature'
param_name_13='AV signature path'
param_name_14='AV signature md5'
param_name_15='AV interval'
param_name_16='DNS interval'
param_name_17='Flow interval'

#params_list=( firmware_build_epoch firmware_path firmware_md5 devfinger_interval netfinger_interval hids_signature hids_sig_path hids_sig_md5 hids_interval fw_interval proxy_interval av_signature av_sig_path av_sig_md5 av_interval dns_interval flow_interval )
#params_names_list=( 'Firmware Build epoch' 'Firmware Build path' 'Firmware md5' 'DevFinger interval' 'NetFinger interval' 'HIDS signature' 'HIDS signature path' 'HIDS signature md5' 'HIDS interval' 'FW interval' 'Proxy interval' 'AV signature' 'AV signature path' 'AV signature md5' 'AV interval' 'DNS interval' 'Flow interval' ) 
#params_list_len=${#params_list[@]}
#params_names_list_len=$(#params_names_list[$]}
params_list_len=6
params_names_list_len=6

if [ ${params_list_len} != ${params_names_list_len} ]; then
	echo "Mismatched array sizes.  params_list:${params_list_len}  and params_names_list:${params_names_list_len}"
	exit 1
fi


# Read in actual or dummy defaults for current variables state
. /etc/config/rune/default

# Modify select vars for deriving from system data
for i in `seq 1 ${params_list_len}`; do
	a=param_$i
	pvar=$(eval echo \$$a)
	get_sys_var_param_$(eval echo \$$a)
	echo "var: ${pvar} is now: $(eval echo \$$pvar)"
done

#for ( i=0; i<${params_list_len}; i++ ); do
for i in `seq 1 ${params_list_len}`; do
	a=param_$i
	b=param_name_$i
	pvar=$(eval echo \$$a)
	pname=$(eval echo \$$b)
	compare_process_param_change $pvar "$pname"
done
