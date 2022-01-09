# Helm

This project contains helm charts of both services. The script to create helm charts is `create-helm-charts.sh`. This creates packages that can be added to helm repository. An example of usage is:
```
./create-helm-charts.sh --version_service1=latest --version_service2=latest
```

To add this packages to helm chart repository, clone the [helmCharts](https://github.com/alexmilis/helmCharts) repository outside of this repository and execute the following commands:
```
cd ../helmCharts
git checkout gh-pages
```

Now copy the newly generated `.tgz` files to that folder and generate the `index.yaml` file.
```
mv servicex-version.tgz helmCharts/
helm repo index helmCharts/ --url https://alexmilis.github.io/helmCharts/
```

After `index.yaml` is generated, commit the changes to git and push to origin. Now the newly added packages are available on `helmCharts` repo. It may take a few minutes for change to take place. The `index.yaml` file can be seen [here](https://alexmilis.github.io/helmCharts/index.yaml).
