<script setup>
const mockrating = 3.5
</script>

<template>
  <a-comment>
    <template #author><a>Han Solo</a></template>
    <template #avatar>
      <a-avatar :size="35" alt="Han Solo" />
    </template>
    <template #content>
      <div class="flex items-center">
        <div style="font-size: 1.5em; color: black; margin-right: 5px;">{{ mockrating }}</div>
        <a-rate disabled v-model:value="mockrating" allow-half />
      </div>
      <p style="color: black;">
        O aparelho limpa com eficiência, cobrindo bem os espaços, e os sensores fazem um ótimo trabalho desviando dos
        móveis e evitando quedas nas escadas. Ele é surpreendentemente silencioso, o que é ótimo, pois consigo deixar
        ele funcionando enquanto trabalho em casa sem distrações.
      </p>
    </template>
  </a-comment>
</template>
