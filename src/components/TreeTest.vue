<template>
  <div>
    <el-row>
      <el-tree
        ref="tree"
        :props="props"
        :load="loadData"
        lazy
        :check-on-click-node="true"
        show-checkbox
        @node-click="nodeClick">
      </el-tree>
    </el-row>
    <el-row>
      <button @click="showCheckedNodesList">获取所有选中节点的数据</button>
    </el-row>
  </div>
</template>

<script>
  export default {
    name: "TreeTest",
    data() {
      return {
        props: {
          label: 'name',
          children: 'children',
          isLeaf: 'leaf'
        },
        selectedNodes: []
      }
    },
    methods: {
      loadData(node, resolve) {
        if (node.level === 0) {
          console.info(0)
          return resolve([{id: 1, name: 'region', children: [], parentId: 0}])
        }
        if (node.level > 1) {
          console.info('大于1')
          return resolve([]);
        }

        setTimeout(() => {
          const data = [{
            id: 11,
            name: 'leaf',
            leaf: true,
            children: [],
            parentId: 1
          }, {
            id: 12,
            name: 'zone',
            leaf: true,
            children: [],
            parentId: 1
          }];

          resolve(data);
        }, 200);
      },
      nodeClick(obj, node) {
        console.info('id:' + obj.id + ':name:' + obj.name + ':children:' + obj.children.length + ':parentId:' + obj.parentId)
        console.info('node-id:' + node.data.id + ':node-name:' + obj.name + ':node-children:' + obj.children.length + 'node-key:' + node.id)
        console.info(node)
      },
      showCheckedNodesList(){
        console.info('选中 节点的长度 ：'+this.$refs.tree.getCheckedNodes().length)
        console.info(this.$refs.tree.getCheckedNodes())

      }
    }
  }
</script>

<style scoped>

</style>
