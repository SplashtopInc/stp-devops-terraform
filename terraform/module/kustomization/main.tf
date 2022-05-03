data "kustomization_build" "this" {
  path = var.path
}

// ids_prio - List of Kustomize resource IDs grouped into three sets.
// ids_prio[0]: Kind: Namespace and Kind: CustomResourceDefinition
// ids_prio[1]: All Kinds not in ids_prio[0] or ids_prio[2]
// ids_prio[2]: Kind: MutatingWebhookConfiguration and Kind: ValidatingWebhookConfiguration

# first loop through resources in ids_prio[0]
resource "kustomization_resource" "p0" {
  for_each = data.kustomization_build.this.ids_prio[0]

  manifest = data.kustomization_build.this.manifests[each.value]
}

# then loop through resources in ids_prio[1]
# and set an explicit depends_on on kustomization_resource.p0
resource "kustomization_resource" "p1" {
  for_each = data.kustomization_build.this.ids_prio[1]

  manifest = data.kustomization_build.this.manifests[each.value]

  depends_on = [kustomization_resource.p0]
}

# finally, loop through resources in ids_prio[2]
# and set an explicit depends_on on kustomization_resource.p1
resource "kustomization_resource" "p2" {
  for_each = data.kustomization_build.this.ids_prio[2]

  manifest = data.kustomization_build.this.manifests[each.value]

  depends_on = [kustomization_resource.p1]
}
