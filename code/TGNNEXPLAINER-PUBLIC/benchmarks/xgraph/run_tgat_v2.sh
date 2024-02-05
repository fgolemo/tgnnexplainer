source /sw/arch/RHEL8/EB_production/2023/software/Anaconda3/2023.07-2/etc/profile.d/conda.sh
conda activate condafact

# run all explainers
dataset=simulate_v2 # wikipedia, reddit, simulate_v1, simulate_v2, mooc
model=tgat # tgat, tgn

#Necessary to train first
START=$(date +%s.%N)
python subgraphx_tg_run.py datasets=${dataset} device_id=0 explainers=pg_explainer_tg models=${model}
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
echo $DIFF

#ours
START=$(date +%s.%N)
python subgraphx_tg_run.py datasets=${dataset} device_id=0 explainers=subgraphx_tg models=${model}
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
echo $DIFF


# baselines
START=$(date +%s.%N)
python subgraphx_tg_run.py datasets=${dataset} device_id=0 explainers=attn_explainer_tg models=${model}
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
echo $DIFF

START=$(date +%s.%N)
python subgraphx_tg_run.py datasets=${dataset} device_id=0 explainers=pbone_explainer_tg models=${model}
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
echo $DIFF
