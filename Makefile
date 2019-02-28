all:
	docker build -t dcferreira/mawi_analysis .
push:
	docker tag dcferreira/mawi_analysis cluster.cn.tuwien.ac.at:5000/dferreira/mawi_analysis
	docker push cluster.cn.tuwien.ac.at:5000/dferreira/mawi_analysis
