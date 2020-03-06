# KubeFed Scale Test

Tools to monotor and visualise Kubefed performance.

- Start kubefed + remaining env in a kubernetes cluster. (the env here can
be any Test/Production env)
- Push resources to Kubefed in the env.
- Monitor Kubefed through `metrics-server` of the host cluster.
- Collect pprof profiles.
- `microk8s.enable metrics-server`

## TODOs

- hardcoded node name

## Resources

- `https://github.com/google/cadvisor/blob/master/docs/storage/prometheus.md`
