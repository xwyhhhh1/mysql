#/bin/bash








source /data/install/utils.fc
if [ $? -eq 0 ] ; then
echo "paas状态检查结果,请关注:"
curl http://$PAAS_FQDN:$PAAS_HTTP_PORT/healthz/
echo "cmdb状态检查结果,请关注:"
curl http://$CMDB_IP:$CMDB_API_PORT/healthz
echo "job状态检查结果,请关注:"
curl http://$JOB_FQDN:$PAAS_HTTP_PORT/healthz
fi
#if [ $? -eq 0 ] ; then
#echo "paas状态检查结果,请关注:"
#curl https://$PAAS_FQDN:$PAAS_HTTPS_PORT/healthz/ -k
#echo "cmdb状态检查结果,请关注:"
#curl https://$CMDB_IP:$CMDB_API_PORT/healthz -k
#echo "job状态检查结果,请关注:"
#curl https://$JOB_FQDN:$PAAS_HTTPS_PORT/healthz -k
#fi
