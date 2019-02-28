#!/bin/sh
ACTION="download"  # run or download
MEMORY="1G"
for year in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019; do
    for month in 1 7; do
	name="mawi_analysis-${year}-${month}"
        docker service create -d --mount type=bind,source=`pwd`,destination=/shared --reserve-memory $MEMORY --limit-memory $MEMORY --user 5016:5019 --name ${name}_0 \
            --restart-condition none \
            cluster.cn.tuwien.ac.at:5000/dferreira/mawi_analysis $ACTION $year $month 0
        docker service create -d --mount type=bind,source=`pwd`,destination=/shared --reserve-memory $MEMORY --limit-memory $MEMORY --user 5016:5019 --name ${name}_1 \
            --restart-condition none \
            cluster.cn.tuwien.ac.at:5000/dferreira/mawi_analysis $ACTION $year $month 1
        docker service create -d --mount type=bind,source=`pwd`,destination=/shared --reserve-memory $MEMORY --limit-memory $MEMORY --user 5016:5019 --name ${name}_2 \
            --restart-condition none \
            cluster.cn.tuwien.ac.at:5000/dferreira/mawi_analysis $ACTION $year $month 2
        docker service create -d --mount type=bind,source=`pwd`,destination=/shared --reserve-memory $MEMORY --limit-memory $MEMORY --user 5016:5019 --name ${name}_3 \
            --restart-condition none \
            cluster.cn.tuwien.ac.at:5000/dferreira/mawi_analysis $ACTION $year $month 3
    done
done
