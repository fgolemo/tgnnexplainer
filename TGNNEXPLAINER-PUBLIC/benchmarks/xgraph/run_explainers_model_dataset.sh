# source /sw/arch/RHEL8/EB_production/2023/software/Anaconda3/2023.07-2/etc/profile.d/conda.sh
# conda activate condafact

# call this script with `bash run_explainers_model_dataset.sh 0 tgat wikipedia` to on the first GPU with dataset wikipedia


# run all explainers
# model = tgn, tgat
# dataset = wikipedia # wikipedia, reddit, simulate_v1, simulate_v2, mooc

gpu=$1
model=$2
dataset=$3

# HOW TO ADD GPU?????!

#Necessary to train first
echo "=== STARTING pg_explainer explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="
python subgraphx_tg_run.py datasets=${dataset} device_id=${gpu} explainers=pg_explainer_tg models=${model}
echo "=== STARTING pg_explainer explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="

# ours
echo "=== STARTING subgraphx explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="
python subgraphx_tg_run.py  datasets=${dataset} device_id=${gpu} explainers=subgraphx_tg models=${model}
echo "=== ENDING subgraphx_tg explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="

# baselines
echo "=== STARTING attn explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="
python subgraphx_tg_run.py datasets=${dataset} device_id=${gpu} explainers=attn_explainer_tg models=${model}
echo "=== ENDING attn_explainer_tg explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="

echo "=== STARTING pbone explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="
python subgraphx_tg_run.py datasets=${dataset} device_id=${gpu} explainers=pbone_explainer_tg models=${model}
echo "=== ENDING pbone explaining on ${model} trained on ${dataset} on GPU ${gpu} ==="

echo "good job :)"

curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd --mail-from 'fgolemo@gmail.com' --mail-rcpt 'fgolemo@gmail.com' --mail-rcpt 'c.isaicu@gmail.com' --user 'fgolemo@gmail.com:cbpd uyvw pzqg fppq' -T <(echo -e "From: fgolemo@gmail.com\nTo: fgolemo@gmail.com,c.isaicu@gmail.com\nSubject: Training Done\n\nFinished ${model} explanation of ==${ds}== on on GPU ==${gpu}==")

