document.addEventListener("DOMContentLoaded", function () {
  const budgetSlider = document.getElementById("budget-slider");
  const minBudgetInput = document.getElementById("min-budget");
  const maxBudgetInput = document.getElementById("max-budget");

  noUiSlider.create(budgetSlider, {
      start: [0, 10000],
      connect: true,
      range: {
          'min': 0,
          'max': 10000
      }
  });

  budgetSlider.noUiSlider.on('update', function (values, handle) {
      const value = values[handle];
      if (handle === 0) {
          minbudgetInput.value = parseInt(value);
      } else {
          maxbudgetInput.value = parseInt(value);
      }
      updateTripsList();
  });

  function updateTripsList() {
      const minPrice = parseInt(minBudgetInput.value);
      const maxPrice = parseInt(maxBudgetInput.value);
      const url = `/trips?min_budget=${minBudget}&max_budget=${maxBudget}`;

      fetch(url)
          .then(response => response.text())
          .then(html => {
              document.querySelector('#trip-list').innerHTML = html;
          });
  }
});
